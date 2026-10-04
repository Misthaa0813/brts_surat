import 'package:flutter/material.dart';

class RouteMapScreen extends StatelessWidget {
  const RouteMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // =====================================================
      // APP BAR
      // =====================================================

      appBar: AppBar(
        backgroundColor: const Color(0xFF214A91),
        foregroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          'Route Map',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // =====================================================
      // ROUTE MAP
      // =====================================================

      body: InteractiveViewer(
        minScale: 1.0,
        maxScale: 5.0,

        panEnabled: true,
        scaleEnabled: true,

        boundaryMargin: const EdgeInsets.all(80),

        child: Center(
          child: Image.asset(
            'assets/images/route_image.jpg',

            fit: BoxFit.contain,

            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }
}
