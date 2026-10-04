import 'package:flutter/material.dart';

import '../models/bus.dart';
import '../models/bus_details.dart';
import '../services/bus_service.dart';

class BusDetailsScreen extends StatefulWidget {
  const BusDetailsScreen({super.key});

  @override
  State<BusDetailsScreen> createState() => _BusDetailsScreenState();
}

class _BusDetailsScreenState extends State<BusDetailsScreen> {
  // All available buses
  List<Bus> buses = [];

  // Currently selected bus
  Bus? selectedBus;

  // Route details received from backend
  List<BusRouteDetails> busRoutes = [];

  // Loading states
  bool isLoading = true;
  bool isLoadingDetails = false;

  // Error messages
  String? errorMessage;
  String? detailsError;

  @override
  void initState() {
    super.initState();
    loadBuses();
  }

  // ------------------------------------------------------------
  // LOAD BUS NUMBERS
  // ------------------------------------------------------------

  Future<void> loadBuses() async {
    try {
      final result = await BusService.getBuses();

      if (!mounted) return;

      setState(() {
        buses = result;
        isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    }
  }

  // ------------------------------------------------------------
  // FIND SELECTED BUS
  // ------------------------------------------------------------

  Future<void> _findBus() async {
    if (selectedBus == null) {
      return;
    }

    setState(() {
      isLoadingDetails = true;
      detailsError = null;
      busRoutes = [];
    });

    try {
      print(
        'Finding bus: ${selectedBus!.busNo}',
      );

      final result = await BusService.getBusDetails(
        selectedBus!.busNo,
      );

      print(
        'Routes received in screen: ${result.length}',
      );

      if (!mounted) return;

      setState(() {
        busRoutes = result;
        isLoadingDetails = false;
      });
    } catch (error) {
      print(
        'ERROR FINDING BUS: $error',
      );

      if (!mounted) return;

      setState(() {
        isLoadingDetails = false;
        detailsError = error.toString();
      });
    }
  }

  // ------------------------------------------------------------
  // MAIN UI
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF172033),

        title: const Text(
          'Bus Details',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : errorMessage != null
                ? _buildErrorState()
                : _buildBusDetails(),
      ),
    );
  }

  // ------------------------------------------------------------
  // BUS DETAILS PAGE
  // ------------------------------------------------------------

  Widget _buildBusDetails() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        20,
        24,
        20,
        30,
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          // ----------------------------------------------------
          // HEADER
          // ----------------------------------------------------

          const Text(
            'Find Your Bus',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color(0xFF172033),
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Select a bus number to view its route details.',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF6B7280),
              height: 1.4,
            ),
          ),

          const SizedBox(height: 28),

          // ----------------------------------------------------
          // BUS SELECTION CARD
          // ----------------------------------------------------

          Container(
            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(22),

              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withValues(alpha: 0.05),

                  blurRadius: 20,

                  offset: const Offset(0, 8),
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                const Text(
                  'Bus Number',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4B5563),
                  ),
                ),

                const SizedBox(height: 10),

                // ------------------------------------------------
                // DROPDOWN
                // ------------------------------------------------

                DropdownButtonFormField<Bus>(
                  initialValue: selectedBus,

                  isExpanded: true,

                  decoration: InputDecoration(
                    hintText:
                        'Select bus number',

                    prefixIcon: const Icon(
                      Icons.directions_bus_rounded,
                      color: Color(0xFF2563EB),
                    ),

                    filled: true,

                    fillColor:
                        const Color(0xFFF7F8FC),

                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(16),

                      borderSide:
                          BorderSide.none,
                    ),

                    contentPadding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),

                  items: buses.map((bus) {
                    return DropdownMenuItem<Bus>(
                      value: bus,

                      child: Text(
                        bus.busNo,

                        style:
                            const TextStyle(
                          fontSize: 16,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),

                  onChanged: (bus) {
                    setState(() {
                      selectedBus = bus;

                      // Clear previous results
                      busRoutes = [];

                      detailsError = null;
                    });
                  },
                ),

                const SizedBox(height: 18),

                // ------------------------------------------------
                // FIND BUS BUTTON
                // ------------------------------------------------

                SizedBox(
                  width: double.infinity,
                  height: 52,

                  child: ElevatedButton.icon(
                    onPressed:
                        selectedBus == null ||
                                isLoadingDetails
                            ? null
                            : _findBus,

                    icon: isLoadingDetails
                        ? const SizedBox(
                            width: 20,
                            height: 20,

                            child:
                                CircularProgressIndicator(
                              strokeWidth: 2,

                              valueColor:
                                  AlwaysStoppedAnimation<
                                      Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.search_rounded,
                          ),

                    label: Text(
                      isLoadingDetails
                          ? 'Finding Bus...'
                          : 'Find Bus',

                      style:
                          const TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF2563EB),

                      foregroundColor:
                          Colors.white,

                      disabledBackgroundColor:
                          const Color(0xFFD1D5DB),

                      disabledForegroundColor:
                          Colors.white,

                      elevation: 0,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // ----------------------------------------------------
          // INITIAL EMPTY STATE
          // ----------------------------------------------------

          if (selectedBus == null)
            _buildEmptyState(),

          // ----------------------------------------------------
          // LOADING DETAILS
          // ----------------------------------------------------

          if (selectedBus != null &&
              isLoadingDetails)
            const Padding(
              padding: EdgeInsets.only(
                top: 30,
              ),

              child: Center(
                child:
                    CircularProgressIndicator(),
              ),
            ),

          // ----------------------------------------------------
          // ERROR
          // ----------------------------------------------------

          if (detailsError != null)
            _buildDetailsError(),

          // ----------------------------------------------------
          // RESULTS
          // ----------------------------------------------------

          if (!isLoadingDetails &&
              detailsError == null &&
              busRoutes.isNotEmpty)
            _buildRouteResults(),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // EMPTY STATE
  // ------------------------------------------------------------

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(28),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(22),
      ),

      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,

            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),

              borderRadius:
                  BorderRadius.circular(20),
            ),

            child: const Icon(
              Icons.route_rounded,

              size: 34,

              color: Color(0xFF2563EB),
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            'Select a bus to get started',

            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xFF172033),
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'You will see the complete route and stops for the selected bus.',

            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // DETAILS ERROR
  // ------------------------------------------------------------

  Widget _buildDetailsError() {
    return Container(
      width: double.infinity,

      margin:
          const EdgeInsets.only(top: 20),

      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(20),

        border: Border.all(
          color: Colors.redAccent
              .withValues(alpha: 0.2),
        ),
      ),

      child: Column(
        children: [
          const Icon(
            Icons.error_outline_rounded,

            size: 45,

            color: Colors.redAccent,
          ),

          const SizedBox(height: 12),

          const Text(
            'Unable to load bus details',

            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            detailsError ??
                'Something went wrong.',

            textAlign: TextAlign.center,

            style: const TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: _findBus,

            child:
                const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // ROUTE RESULTS
  // ------------------------------------------------------------

  Widget _buildRouteResults() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        const Text(
          'Route Details',

          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF172033),
          ),
        ),

        const SizedBox(height: 12),

        Text(
          '${busRoutes.length} route${busRoutes.length == 1 ? '' : 's'} found for ${selectedBus!.busNo}',

          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF6B7280),
          ),
        ),

        const SizedBox(height: 18),

        // Display every route
        ...busRoutes.map(
          (route) => _buildRouteCard(route),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // ROUTE CARD
  // ------------------------------------------------------------

  Widget _buildRouteCard(
    BusRouteDetails route,
  ) {
    return Container(
      width: double.infinity,

      margin:
          const EdgeInsets.only(bottom: 20),

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withValues(alpha: 0.05),

            blurRadius: 18,

            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          // ----------------------------------------------------
          // BUS HEADER
          // ----------------------------------------------------

          Row(
            children: [
              Container(
                width: 48,
                height: 48,

                decoration: BoxDecoration(
                  color:
                      const Color(0xFFEFF6FF),

                  borderRadius:
                      BorderRadius.circular(14),
                ),

                child: const Icon(
                  Icons.directions_bus_rounded,

                  color:
                      Color(0xFF2563EB),

                  size: 26,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      route.busNo,

                      style:
                          const TextStyle(
                        fontSize: 20,
                        fontWeight:
                            FontWeight.w800,
                        color:
                            Color(0xFF172033),
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      'Route ${route.routeId}',

                      style:
                          const TextStyle(
                        fontSize: 13,
                        color:
                            Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),

              // Direction badge
              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),

                decoration: BoxDecoration(
                  color:
                      const Color(0xFFEFF6FF),

                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: Text(
                  route.direction,

                  style:
                      const TextStyle(
                    fontSize: 12,
                    fontWeight:
                        FontWeight.w700,
                    color:
                        Color(0xFF2563EB),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // ----------------------------------------------------
          // START STOP
          // ----------------------------------------------------

          _buildRoutePoint(
            icon: Icons.trip_origin_rounded,
            title: 'Starting Point',
            value: route.startStop,
            isFirst: true,
          ),

          // Connecting line
          Padding(
            padding:
                const EdgeInsets.only(
              left: 11,
            ),

            child: Container(
              height: 25,
              width: 2,

              color:
                  const Color(0xFFD1D5DB),
            ),
          ),

          // ----------------------------------------------------
          // END STOP
          // ----------------------------------------------------

          _buildRoutePoint(
            icon: Icons.location_on_rounded,
            title: 'Destination',
            value: route.endStop,
            isFirst: false,
          ),

          const SizedBox(height: 20),

          // ----------------------------------------------------
          // TOTAL STOPS
          // ----------------------------------------------------

          Container(
            width: double.infinity,

            padding:
                const EdgeInsets.all(14),

            decoration: BoxDecoration(
              color:
                  const Color(0xFFF7F8FC),

              borderRadius:
                  BorderRadius.circular(14),
            ),

            child: Row(
              children: [
                const Icon(
                  Icons.location_on_rounded,

                  color:
                      Color(0xFF2563EB),

                  size: 22,
                ),

                const SizedBox(width: 10),

                Text(
                  '${route.totalStops} stops',

                  style:
                      const TextStyle(
                    fontSize: 15,
                    fontWeight:
                        FontWeight.w700,
                    color:
                        Color(0xFF172033),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          // ----------------------------------------------------
          // ALL STOPS
          // ----------------------------------------------------

          const Text(
            'All Stops',

            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF172033),
            ),
          ),

          const SizedBox(height: 14),

          // List of stops
          ...route.stops.map(
            (stop) => _buildStopItem(stop),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // ROUTE POINT
  // ------------------------------------------------------------

  Widget _buildRoutePoint({
    required IconData icon,
    required String title,
    required String value,
    required bool isFirst,
  }) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Icon(
          icon,

          size: 24,

          color: isFirst
              ? const Color(0xFF2563EB)
              : Colors.redAccent,
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                title,

                style:
                    const TextStyle(
                  fontSize: 12,
                  color:
                      Color(0xFF6B7280),
                  fontWeight:
                      FontWeight.w600,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                value,

                style:
                    const TextStyle(
                  fontSize: 15,
                  fontWeight:
                      FontWeight.w700,
                  color:
                      Color(0xFF172033),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // INDIVIDUAL STOP
  // ------------------------------------------------------------

  Widget _buildStopItem(
    BusStop stop,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 14,
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          // Stop number
          Container(
            width: 32,
            height: 32,

            alignment:
                Alignment.center,

            decoration: BoxDecoration(
              color:
                  const Color(0xFFEFF6FF),

              borderRadius:
                  BorderRadius.circular(10),
            ),

            child: Text(
              '${stop.stopOrder}',

              style:
                  const TextStyle(
                fontSize: 12,
                fontWeight:
                    FontWeight.w800,
                color:
                    Color(0xFF2563EB),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Stop name
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(
                top: 6,
              ),

              child: Text(
                stop.stopName,

                style:
                    const TextStyle(
                  fontSize: 14,
                  fontWeight:
                      FontWeight.w600,
                  color:
                      Color(0xFF374151),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // GENERAL ERROR STATE
  // ------------------------------------------------------------

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.all(24),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            const Icon(
              Icons.error_outline_rounded,

              size: 60,

              color: Colors.redAccent,
            ),

            const SizedBox(height: 16),

            const Text(
              'Unable to load buses',

              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.w700,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              errorMessage ??
                  'Something went wrong.',

              textAlign:
                  TextAlign.center,

              style:
                  const TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                  errorMessage = null;
                });

                loadBuses();
              },

              child:
                  const Text('Try Again'),
            ),

          ],
        ),
      ),
    );
  }
}