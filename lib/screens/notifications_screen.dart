import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),

      // --------------------------------------------------------
      // APP BAR
      // --------------------------------------------------------

      appBar: AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: const Color(0xFF214A91),

        elevation: 0,

        toolbarHeight: 48,

        titleSpacing: 0,

        title: Row(
          children: [
            // Back button
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },

              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xFFE6D84A),
                size: 22,
              ),

              padding: const EdgeInsets.only(
                left: 4,
                right: 8,
              ),

              constraints: const BoxConstraints(),
            ),

            const SizedBox(width: 10),

            const Text(
              'notifications',
              style: TextStyle(
                color: Color(0xFFE6D84A),
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),

      // --------------------------------------------------------
      // BODY
      // --------------------------------------------------------

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            9,
            14,
            9,
            30,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // ------------------------------------------------
              // NOTIFICATION COUNT
              // ------------------------------------------------

              const Text(
                'You have 4 new notifications',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4776A8),
                ),
              ),

              const SizedBox(height: 10),

              // ------------------------------------------------
              // NOTIFICATION 1
              // ------------------------------------------------

              _buildNotificationCard(
                title: 'Heavy Rain in Adajan 🌧️',
                description:
                    'Check live bus timings to avoid waterlogged roads.',
              ),

              const SizedBox(height: 9),

              // ------------------------------------------------
              // NOTIFICATION 2
              // ------------------------------------------------

              _buildNotificationCard(
                title: 'Happy Hour is Live! 💎',
                description:
                    'Get 20% off all BRTS bookings for the next 2 hours.',
              ),

              const SizedBox(height: 9),

              // ------------------------------------------------
              // NOTIFICATION 3
              // ------------------------------------------------

              _buildNotificationCard(
                title: 'Low Wallet Balance 💳',
                description:
                    'Top up your account now to avoid delays at the gate.',
              ),

              const SizedBox(height: 9),

              // ------------------------------------------------
              // NOTIFICATION 4
              // ------------------------------------------------

              _buildNotificationCard(
                title: 'Planning a trip to Sarthana? 🌳',
                description:
                    'Red Line is under construction — check your fastest route.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // NOTIFICATION CARD
  // ============================================================

  Widget _buildNotificationCard({
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.fromLTRB(
        13,
        11,
        13,
        11,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(10),

        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.12,
            ),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          // ----------------------------------------------------
          // TITLE
          // ----------------------------------------------------

          Text(
            title,
            style: const TextStyle(
              fontSize: 15.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF222222),
            ),
          ),

          const SizedBox(height: 4),

          // ----------------------------------------------------
          // DESCRIPTION
          // ----------------------------------------------------

          Text(
            description,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w400,
              color: Color(0xFF666666),
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}