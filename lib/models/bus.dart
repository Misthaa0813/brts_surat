class Bus {
  final String busNo;

  Bus({
    required this.busNo,
  });

  factory Bus.fromJson(String json) {
    return Bus(
      busNo: json,
    );
  }
}