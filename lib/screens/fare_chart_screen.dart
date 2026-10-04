import 'package:flutter/material.dart';

class FareChartScreen extends StatelessWidget {
  const FareChartScreen({super.key});

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
          'Fare Chart',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // =====================================================
      // FARE TABLES
      // =====================================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =================================================
            // TABLE 1 — DISTANCE WISE FARE
            // =================================================

            const Text(
              'Distance-wise Ticket Fare',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF172033),
              ),
            ),

            const SizedBox(height: 16),

            _buildDistanceFareTable(),

            const SizedBox(height: 40),

            // =================================================
            // TABLE 2 — PASS CHARGES
            // =================================================

            const Text(
              'Pass Charges',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF172033),
              ),
            ),

            const SizedBox(height: 16),

            _buildPassFareTable(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // DISTANCE FARE TABLE
  // =========================================================

  Widget _buildDistanceFareTable() {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        children: [

          // Header
          _buildTableRow(
            cells: const [
              'Distance Traveled',
              'Ticket Fare (₹)',
            ],
            isHeader: true,
          ),

          _buildTableRow(
            cells: const [
              '0 to 2 km',
              '₹5',
            ],
          ),

          _buildTableRow(
            cells: const [
              '2 to 4 km',
              '₹10',
            ],
          ),

          _buildTableRow(
            cells: const [
              '4 to 6 km',
              '₹15',
            ],
          ),

          _buildTableRow(
            cells: const [
              '6 to 10 km',
              '₹20',
            ],
          ),

          _buildTableRow(
            cells: const [
              'Over 10 km (Maximum)',
              '₹25',
            ],
            isLast: true,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // PASS FARE TABLE
  // =========================================================

  Widget _buildPassFareTable() {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        children: [

          // Header
          _buildTableRow(
            cells: const [
              'Pass Duration',
              'Student & Women\nSpecial Rate (₹)',
              'Institutional / General\nPublic Rate (₹)',
            ],
            isHeader: true,
          ),

          _buildTableRow(
            cells: const [
              '1 Month / Monthly',
              '₹100',
              '₹700',
            ],
          ),

          _buildTableRow(
            cells: const [
              '3 Months / Quarterly',
              '₹300',
              '₹1,900',
            ],
          ),

          _buildTableRow(
            cells: const [
              '6 Months / Half-Yearly',
              '₹500',
              '₹3,600',
            ],
          ),

          _buildTableRow(
            cells: const [
              '1 Year / Yearly',
              '₹1,000',
              '₹7,000',
            ],
            isLast: true,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // TABLE ROW
  // =========================================================

  Widget _buildTableRow({
    required List<String> cells,
    bool isHeader = false,
    bool isLast = false,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 18,
      ),

      decoration: BoxDecoration(
        color: isHeader
            ? const Color(0xFFF1F5F9)
            : Colors.white,

        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: List.generate(
          cells.length,
          (index) {
            return Expanded(
              flex: index == 0 ? 2 : 1,

              child: Text(
                cells[index],
                textAlign: index == 0
                    ? TextAlign.left
                    : TextAlign.center,

                style: TextStyle(
                  fontSize: isHeader ? 14 : 15,
                  fontWeight: isHeader
                      ? FontWeight.w700
                      : FontWeight.w500,
                  color: const Color(0xFF172033),
                  height: 1.4,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}