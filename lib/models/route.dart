class BusRoute {
  final int routeId;
  final String busNo;
  final String direction;
  final String startStop;
  final String endStop;
  final int fromStopId;
  final int toStopId;
  final int fromOrder;
  final int toOrder;

  BusRoute({
    required this.routeId,
    required this.busNo,
    required this.direction,
    required this.startStop,
    required this.endStop,
    required this.fromStopId,
    required this.toStopId,
    required this.fromOrder,
    required this.toOrder,
  });

  factory BusRoute.fromJson(Map<String, dynamic> json) {
    return BusRoute(
      routeId: json['route_id'],
      busNo: json['bus_no'],
      direction: json['direction'],
      startStop: json['start_stop'],
      endStop: json['end_stop'],
      fromStopId: json['from_stop_id'],
      toStopId: json['to_stop_id'],
      fromOrder: json['from_order'],
      toOrder: json['to_order'],
    );
  }
}