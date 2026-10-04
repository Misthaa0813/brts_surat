import 'package:flutter/material.dart';

import 'screens/plan_trip_screen.dart';
import 'screens/bus_details_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/my_tickets_screen.dart';
import 'screens/route_map_screen.dart';
import 'screens/fare_chart_screen.dart';

void main() {
  runApp(const BRTSSuratApp());
}

class BRTSSuratApp extends StatelessWidget {
  const BRTSSuratApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BRTS Surat',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),

      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BRTS Surat',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const NotificationsScreen(),
                ),
              );
            },

            icon: const Icon(
              Icons.notifications_outlined,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // ==================================================
            // WELCOME SECTION
            // ==================================================

            const Text(
              'Welcome to BRTS Surat',

              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Travel smarter, faster and easier.',

              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 24),

            // ==================================================
            // PLAN YOUR TRIP
            // ==================================================

            _buildMainCard(
              context,

              icon: Icons.directions_bus,

              title: 'Plan Your Trip',

              subtitle:
                  'Find the best route for your journey',

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const PlanTripScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // ==================================================
            // BUS DETAILS
            // ==================================================

            _buildMainCard(
              context,

              icon: Icons.directions_bus_outlined,

              title: 'Bus Details',

              subtitle:
                  'Find bus routes and stops',

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const BusDetailsScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // ==================================================
            // QUICK ACCESS TITLE
            // ==================================================

            const Text(
              'Quick Access',

              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // ==================================================
            // QUICK ACCESS GRID
            // ==================================================

            GridView.count(
              crossAxisCount: 2,

              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              crossAxisSpacing: 12,

              mainAxisSpacing: 12,

              childAspectRatio: 1.4,

              children: [
                // ------------------------------------------------
                // 1. MY TICKETS
                // ------------------------------------------------

                _buildQuickCard(
                  icon: Icons.receipt_long_outlined,
                  title: 'My Tickets',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const MyTicketsScreen(),
                      ),
                    );
                  },
                ),          

                // ------------------------------------------------
                // 2. NOTIFICATIONS
                // ------------------------------------------------

                _buildQuickCard(
                  icon:
                      Icons.notifications_outlined,

                  title: 'Notifications',

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const NotificationsScreen(),
                      ),
                    );
                  },
                ),

                // ------------------------------------------------
                // 3. FARE CHART
                // ------------------------------------------------

                _buildQuickCard(
                  icon: Icons.currency_rupee,
                  title: 'Fare Chart',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const FareChartScreen(),
                      ),
                    );
                  },
                ),

                // ------------------------------------------------
                // 4. ROUTE MAP
                // ------------------------------------------------

                _buildQuickCard(
                  icon: Icons.map_outlined,
                  title: 'Route Map',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const RouteMapScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // MAIN CARD
  // ============================================================

  Widget _buildMainCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,

      child: InkWell(
        onTap: onTap,

        borderRadius:
            BorderRadius.circular(12),

        child: Padding(
          padding:
              const EdgeInsets.all(20),

          child: Row(
            children: [
              // ------------------------------------------------
              // ICON
              // ------------------------------------------------

              Container(
                padding:
                    const EdgeInsets.all(14),

                decoration:
                    BoxDecoration(
                  color:
                      Colors.blue.shade50,

                  borderRadius:
                      BorderRadius.circular(12),
                ),

                child: Icon(
                  icon,

                  size: 32,

                  color: Colors.blue,
                ),
              ),

              const SizedBox(width: 16),

              // ------------------------------------------------
              // TEXT
              // ------------------------------------------------

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      title,

                      style:
                          const TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      subtitle,

                      style:
                          const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              // ------------------------------------------------
              // ARROW
              // ------------------------------------------------

              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // QUICK ACCESS CARD
  // ============================================================

  Widget _buildQuickCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,

      child: InkWell(
        onTap: onTap,

        borderRadius:
            BorderRadius.circular(12),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            // --------------------------------------------------
            // ICON
            // --------------------------------------------------

            Icon(
              icon,

              size: 32,

              color: Colors.blue,
            ),

            const SizedBox(height: 10),

            // --------------------------------------------------
            // TITLE
            // --------------------------------------------------

            Text(
              title,

              style:
                  const TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}