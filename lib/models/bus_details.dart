class BusStop {
  final int stopId;
  final String stopName;
  final int stopOrder;

  BusStop({
    required this.stopId,
    required this.stopName,
    required this.stopOrder,
  });

  factory BusStop.fromJson(Map<String, dynamic> json) {
    return BusStop(
      stopId: json['stop_id'],
      stopName: json['stop_name'],
      stopOrder: json['stop_order'],
    );
  }
}

class BusRouteDetails {
  final int routeId;
  final String busNo;
  final String direction;
  final String startStop;
  final String endStop;
  final int totalStops;
  final List<BusStop> stops;

  BusRouteDetails({
    required this.routeId,
    required this.busNo,
    required this.direction,
    required this.startStop,
    required this.endStop,
    required this.totalStops,
    required this.stops,
  });

  factory BusRouteDetails.fromJson(Map<String, dynamic> json) {
    return BusRouteDetails(
      routeId: json['route_id'],
      busNo: json['bus_no'],
      direction: json['direction'],
      startStop: json['start_stop'],
      endStop: json['end_stop'],
      totalStops: json['total_stops'],
      stops: (json['stops'] as List)
          .map((stop) => BusStop.fromJson(stop))
          .toList(),
    );
  }
}