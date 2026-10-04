import 'package:flutter/material.dart';

class MyTicketsScreen extends StatefulWidget {
  const MyTicketsScreen({super.key});

  @override
  State<MyTicketsScreen> createState() =>
      _MyTicketsScreenState();
}

class _MyTicketsScreenState
    extends State<MyTicketsScreen> {
  // Keeps track of which tickets are expanded.
  final Set<String> expandedTickets = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),

      // =========================================================
      // APP BAR
      // =========================================================

      appBar: AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: const Color(0xFF214A91),

        elevation: 0,

        toolbarHeight: 48,

        titleSpacing: 0,

        title: Row(
          children: [
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

              constraints:
                  const BoxConstraints(),
            ),

            const SizedBox(width: 10),

            const Text(
              'My Tickets',
              style: TextStyle(
                color: Color(0xFFE6D84A),
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),

      // =========================================================
      // BODY
      // =========================================================

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            10,
            14,
            10,
            30,
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // =================================================
              // RECENT TICKETS
              // =================================================

              const Text(
                'Recent Tickets',

                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4776A8),
                ),
              ),

              const SizedBox(height: 8),

              // Ticket A
              _buildTicketCard(
                ticketName: 'Ticket A',
                busNumber: 'Bus 12U',
                ticketId:
                    'SBRTS123456789001',
                fare: '₹20',

                passengers: [
                  _Passenger(
                    name: 'Rahul Sharma',
                    age: 24,
                  ),
                  _Passenger(
                    name: 'Priya Sharma',
                    age: 22,
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Ticket B
              _buildTicketCard(
                ticketName: 'Ticket B',
                busNumber: 'Bus 45A',
                ticketId:
                    'SBRTS123456789002',
                fare: '₹75',

                passengers: [
                  _Passenger(
                    name: 'Aarav Patel',
                    age: 28,
                  ),
                  _Passenger(
                    name: 'Meera Patel',
                    age: 25,
                  ),
                  _Passenger(
                    name: 'Riya Patel',
                    age: 8,
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // =================================================
              // PAST TICKETS
              // =================================================

              const Text(
                'Past Tickets',

                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4776A8),
                ),
              ),

              const SizedBox(height: 8),

              // Ticket C
              _buildTicketCard(
                ticketName: 'Ticket C',
                busNumber: 'Bus 8B',
                ticketId:
                    'SBRTS123456789003',
                fare: '₹10',

                passengers: [
                  _Passenger(
                    name: 'Karan Shah',
                    age: 31,
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Ticket D
              _buildTicketCard(
                ticketName: 'Ticket D',
                busNumber: 'Bus 21C',
                ticketId:
                    'SBRTS123456789004',
                fare: '₹50',

                passengers: [
                  _Passenger(
                    name: 'Neha Joshi',
                    age: 26,
                  ),
                  _Passenger(
                    name: 'Amit Joshi',
                    age: 29,
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Ticket E
              _buildTicketCard(
                ticketName: 'Ticket E',
                busNumber: 'Bus 33D',
                ticketId:
                    'SBRTS123456789005',
                fare: '₹15',

                passengers: [
                  _Passenger(
                    name: 'Ananya Mehta',
                    age: 21,
                  ),
                  _Passenger(
                    name: 'Rohan Mehta',
                    age: 23,
                  ),
                  _Passenger(
                    name: 'Kabir Mehta',
                    age: 6,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =============================================================
  // TICKET CARD
  // =============================================================

  Widget _buildTicketCard({
    required String ticketName,
    required String busNumber,
    required String ticketId,
    required String fare,
    required List<_Passenger> passengers,
  }) {
    final bool isExpanded =
        expandedTickets.contains(ticketId);

    return AnimatedContainer(
      duration:
          const Duration(milliseconds: 250),

      width: double.infinity,

      padding: const EdgeInsets.fromLTRB(
        12,
        10,
        8,
        10,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(10),

        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.10,
            ),

            blurRadius: 5,

            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Column(
        children: [
          // =====================================================
          // BASIC TICKET INFORMATION
          // =====================================================

          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // -------------------------------------------------
              // LEFT SIDE
              // -------------------------------------------------

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    // Ticket name
                    Text(
                      ticketName,

                      style:
                          const TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.w600,
                        color:
                            Color(0xFF777777),
                      ),
                    ),

                    const SizedBox(height: 3),

                    // Bus number
                    Text(
                      busNumber,

                      style:
                          const TextStyle(
                        fontSize: 17,
                        fontWeight:
                            FontWeight.w700,
                        color:
                            Color(0xFF222222),
                      ),
                    ),

                    const SizedBox(height: 3),

                    // Ticket ID
                    Text(
                      'ID: $ticketId',

                      style:
                          const TextStyle(
                        fontSize: 10.5,
                        color:
                            Color(0xFF888888),
                      ),
                    ),
                  ],
                ),
              ),

              // -------------------------------------------------
              // RIGHT SIDE
              // -------------------------------------------------

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,

                children: [
                  // Fare
                  Text(
                    fare,

                    style:
                        const TextStyle(
                      fontSize: 15,
                      fontWeight:
                          FontWeight.w700,
                      color:
                          Color(0xFF4F4F4F),
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Show More / Show Less
                  SizedBox(
                    height: 32,

                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (isExpanded) {
                            expandedTickets
                                .remove(ticketId);
                          } else {
                            expandedTickets
                                .add(ticketId);
                          }
                        });
                      },

                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(
                          0xFF1769AA,
                        ),

                        foregroundColor:
                            Colors.white,

                        elevation: 0,

                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 12,
                        ),

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(5),
                        ),
                      ),

                      child: Text(
                        isExpanded
                            ? 'Show Less'
                            : 'Show More',

                        style:
                            const TextStyle(
                          fontSize: 11,
                          fontWeight:
                              FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // =====================================================
          // EXPANDED PASSENGER DETAILS
          // =====================================================

          if (isExpanded) ...[
            const SizedBox(height: 16),

            Container(
              width: double.infinity,

              height: 1,

              color:
                  const Color(0xFFE5E5E5),
            ),

            const SizedBox(height: 14),

            // Passenger count
            Row(
              children: [
                const Icon(
                  Icons.people_outline,
                  size: 20,
                  color: Color(0xFF1769AA),
                ),

                const SizedBox(width: 7),

                Text(
                  'Passengers: ${passengers.length}',

                  style:
                      const TextStyle(
                    fontSize: 15,
                    fontWeight:
                        FontWeight.w700,
                    color:
                        Color(0xFF333333),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Passenger list
            ...List.generate(
              passengers.length,
              (index) {
                final passenger =
                    passengers[index];

                return _buildPassengerRow(
                  passengerNumber:
                      index + 1,

                  passenger:
                      passenger,

                  isLast:
                      index ==
                          passengers.length -
                              1,
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  // =============================================================
  // PASSENGER ROW
  // =============================================================

  Widget _buildPassengerRow({
    required int passengerNumber,
    required _Passenger passenger,
    required bool isLast,
  }) {
    return Container(
      width: double.infinity,

      margin: EdgeInsets.only(
        bottom: isLast ? 0 : 10,
      ),

      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FC),

        borderRadius:
            BorderRadius.circular(8),

        border: Border.all(
          color: const Color(0xFFE6E6E6),
        ),
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          // Passenger number
          Container(
            width: 30,
            height: 30,

            alignment:
                Alignment.center,

            decoration: BoxDecoration(
              color:
                  const Color(0xFF1769AA),

              borderRadius:
                  BorderRadius.circular(15),
            ),

            child: Text(
              '$passengerNumber',

              style:
                  const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight:
                    FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Passenger information
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  'Passenger $passengerNumber',

                  style:
                      const TextStyle(
                    fontSize: 13,
                    color:
                        Color(0xFF777777),
                    fontWeight:
                        FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  passenger.name,

                  style:
                      const TextStyle(
                    fontSize: 15,
                    fontWeight:
                        FontWeight.w700,
                    color:
                        Color(0xFF222222),
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  'Age: ${passenger.age}',

                  style:
                      const TextStyle(
                    fontSize: 13,
                    color:
                        Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===============================================================
// PASSENGER MODEL
// ===============================================================

class _Passenger {
  final String name;
  final int age;

  _Passenger({
    required this.name,
    required this.age,
  });
}