import 'dart:convert';

class AttendanceEntities {
  final String employeeId;
  final String regNo;
  final String clockType;
  final String clockInLat;
  final String clockInLng;
  final String clockInImage;
  final String clockInTime;
  AttendanceEntities({
    required this.employeeId,
    required this.regNo,
    required this.clockType,
    required this.clockInLat,
    required this.clockInLng,
    required this.clockInImage,
    required this.clockInTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'employeeId': employeeId,
      'regNo': regNo,
      'clockType': clockType,
      'clockInLat': clockInLat,
      'clockInLng': clockInLng,
      'clockInImage': clockInImage,
      'clockInTime': clockInTime,
    };
  }

  factory AttendanceEntities.fromMap(Map<String, dynamic> map) {
    return AttendanceEntities(
      employeeId: map['employeeId'] ?? '',
      regNo: map['regNo'] ?? '',
      clockType: map['clockType'] ?? '',
      clockInLat: map['clockInLat'] ?? "",
      clockInLng: map['clockInLng'] ?? "",
      clockInImage: map['clockInImage'] ?? '',
      clockInTime: map['clockInTime'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceEntities.fromJson(String source) =>
      AttendanceEntities.fromMap(json.decode(source));
}
