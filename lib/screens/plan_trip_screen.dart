import 'package:flutter/material.dart';

import '../models/stop.dart';
import '../services/stop_service.dart';

import '../services/route_service.dart';

class PlanTripScreen extends StatefulWidget {
  const PlanTripScreen({super.key});

  @override
  State<PlanTripScreen> createState() => _PlanTripScreenState();
}

class _PlanTripScreenState extends State<PlanTripScreen> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  List<Stop> stops = [];
  bool isLoadingStops = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadStops();
  }

  Future<void> loadStops() async {
    try {
      final loadedStops = await StopService.getStops();

      if (!mounted) return;

      setState(() {
        stops = loadedStops;
        isLoadingStops = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        isLoadingStops = false;
        errorMessage = 'Failed to load BRTS stops';
      });
    }
  }

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  void showStopSelection({
    required TextEditingController controller,
    required String title,
  }) {
    if (isLoadingStops) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('BRTS stops are still loading...'),
        ),
      );
      return;
    }

    if (errorMessage != null || stops.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not load BRTS stops'),
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return _StopSelectionSheet(
          title: title,
          stops: stops,
          onStopSelected: (stop) {
            controller.text = stop.stopName;
            Navigator.pop(context);
          },
        );
      },
    );
  }
  Future<void> findRoute() async {
    if (fromController.text.isEmpty || toController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both From and To stops'),
        ),
      );
      return;
    }

    try {
      // Find the selected stop objects using their names
      final fromStop = stops.firstWhere(
        (stop) => stop.stopName == fromController.text,
      );

      final toStop = stops.firstWhere(
        (stop) => stop.stopName == toController.text,
      );

      final routes = await RouteService.findRoutes(
        fromStop.stopId,
        toStop.stopId,
      );

      if (!mounted) return;

      if (routes.isEmpty) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('No Route Found'),
              content: Text(
                'No direct BRTS route was found from '
                '${fromStop.stopName} to ${toStop.stopName}.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

        
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        final route = routes.first;

        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // HEADER
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.directions_bus_rounded,
                        color: Colors.blue.shade600,
                        size: 32,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Route Found',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Here’s your BRTS route',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.grey.shade500,
                        size: 26,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                // BUS INFORMATION
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.directions_bus_rounded,
                                color: Colors.blue.shade600,
                              ),
                            ),

                            const SizedBox(width: 10),

                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bus Number',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  route.busNo,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 1,
                        height: 45,
                        color: Colors.grey.shade300,
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_upward_rounded,
                                color: Colors.green.shade600,
                              ),
                            ),

                            const SizedBox(width: 10),

                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Direction',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  route.direction,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // JOURNEY
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      // FROM
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.location_on_rounded,
                              color: Colors.green.shade600,
                              size: 22,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'FROM',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade600,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  fromStop.stopName,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // CONNECTION LINE
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 18,
                          top: 4,
                          bottom: 4,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 2,
                            height: 25,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),

                      // TO
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.location_on_rounded,
                              color: Colors.red.shade600,
                              size: 22,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'TO',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade600,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  toStop.stopName,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // OK BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to find route: $error'),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Plan Your Trip',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Where do you want to go?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: fromController,
              readOnly: true,
              onTap: () {
                showStopSelection(
                  controller: fromController,
                  title: 'Select Starting Point',
                );
              },
              decoration: InputDecoration(
                labelText: 'From',
                hintText: 'Select starting point',
                prefixIcon: const Icon(
                  Icons.location_on_outlined,
                ),
                suffixIcon: const Icon(Icons.arrow_drop_down),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: toController,
              readOnly: true,
              onTap: () {
                showStopSelection(
                  controller: toController,
                  title: 'Select Destination',
                );
              },
              decoration: InputDecoration(
                labelText: 'To',
                hintText: 'Select destination',
                prefixIcon: const Icon(
                  Icons.location_on,
                ),
                suffixIcon: const Icon(Icons.arrow_drop_down),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: findRoute,
                icon: const Icon(Icons.search),
                label: const Text(
                  'Find Route',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 16),

            if (isLoadingStops)
              const Center(
                child: CircularProgressIndicator(),
              ),

            if (errorMessage != null)
              Center(
                child: Text(
                  errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),

            if (!isLoadingStops && errorMessage == null)
              Center(
                child: Text(
                  '${stops.length} BRTS stops loaded',
                  style: const TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StopSelectionSheet extends StatefulWidget {
  final String title;
  final List<Stop> stops;
  final Function(Stop) onStopSelected;

  const _StopSelectionSheet({
    required this.title,
    required this.stops,
    required this.onStopSelected,
  });

  @override
  State<_StopSelectionSheet> createState() => _StopSelectionSheetState();
}

class _StopSelectionSheetState extends State<_StopSelectionSheet> {
  final TextEditingController searchController = TextEditingController();

  List<Stop> filteredStops = [];

  @override
  void initState() {
    super.initState();
    filteredStops = widget.stops;
    searchController.addListener(filterStops);
  }

  void filterStops() {
    final query = searchController.text.toLowerCase().trim();

    setState(() {
      if (query.isEmpty) {
        filteredStops = widget.stops;
      } else {
        filteredStops = widget.stops.where((stop) {
          return stop.stopName.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    searchController.removeListener(filterStops);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search BRTS stop',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: filteredStops.isEmpty
                  ? const Center(
                      child: Text('No stops found'),
                    )
                  : ListView.builder(
                      itemCount: filteredStops.length,
                      itemBuilder: (context, index) {
                        final stop = filteredStops[index];

                        return ListTile(
                          leading: const Icon(
                            Icons.location_on_outlined,
                          ),
                          title: Text(stop.stopName),
                          subtitle: Text(
                            'Stop ID: ${stop.stopId}',
                          ),
                          onTap: () {
                            widget.onStopSelected(stop);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}