class Stop {
  final int stopId;
  final String stopName;

  Stop({
    required this.stopId,
    required this.stopName,
  });

  factory Stop.fromJson(Map<String, dynamic> json) {
    return Stop(
      stopId: json['stop_id'],
      stopName: json['stop_name'],
    );
  }
}