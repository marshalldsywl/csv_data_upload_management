class DeviceData {
  final String serial;
  final String name;
  final String dateTime;
  final double co;
  final double so;
  final double pm25;

  DeviceData({required this.serial, required this.name, required this.dateTime, required this.co, required this.so, required this.pm25});

  Map<String, dynamic> toMap() {
    return {
      'serial': serial,
      'name': name,
      'dateTime': dateTime,
      'co': co,
      'so': so,
      'pm25': pm25,
    };
  }

  factory DeviceData.fromMap(Map<String, dynamic> map) {
    return DeviceData(
      serial: map['serial'],
      name: map['name'],
      dateTime: map['dateTime'],
      co: map['co'],
      so: map['so'],
      pm25: map['pm25'],
    );
  }
}
