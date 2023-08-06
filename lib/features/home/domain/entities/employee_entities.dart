import 'dart:convert';

class EmployeesEntities {
  final String employeeId;
  final String fullName;
  final String designation;
  final String regNo;
  final String dateOfBirth;
  final String joiningDate;
  final String sex;
  final String phoneNumber;
  final String email;
  final String profilePicture;
  EmployeesEntities({
    required this.employeeId,
    required this.fullName,
    required this.designation,
    required this.regNo,
    required this.dateOfBirth,
    required this.joiningDate,
    required this.sex,
    required this.phoneNumber,
    required this.email,
    required this.profilePicture,
  });

  Map<String, dynamic> toMap() {
    return {
      'employeeId': employeeId,
      'fullName': fullName,
      'designation': designation,
      'regNo': regNo,
      'dateOfBirth': dateOfBirth,
      'joiningDate': joiningDate,
      'sex': sex,
      'phoneNumber': phoneNumber,
      'email': email,
      'profilePicture': profilePicture,
    };
  }

  factory EmployeesEntities.fromMap(Map<String, dynamic> map) {
    return EmployeesEntities(
      employeeId: map['employeeId'] ?? '',
      fullName: map['fullName'] ?? '',
      designation: map['designation'] ?? '',
      regNo: map['regNo'] ?? "",
      dateOfBirth: map['dateOfBirth'] ?? '',
      joiningDate: map['joiningDate'] ?? '',
      sex: map['sex'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeesEntities.fromJson(String source) =>
      EmployeesEntities.fromMap(json.decode(source));
}
