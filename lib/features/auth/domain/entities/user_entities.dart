// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class UserEntities {
  final String token;
  final String expires_in;
  final String validTo;
  final UserDataEntities user;
  UserEntities({
    required this.token,
    required this.expires_in,
    required this.validTo,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'expires_in': expires_in,
      'validTo': validTo,
      'user': user.toMap(),
    };
  }

  factory UserEntities.fromMap(Map<String, dynamic> map) {
    return UserEntities(
      token: map['token'] ?? '',
      expires_in: map['expires_in'] ?? '',
      validTo: map['validTo'] ?? '',
      user: UserDataEntities.fromMap(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntities.fromJson(String source) =>
      UserEntities.fromMap(json.decode(source));
}

class UserDataEntities {
  final String companyId;
  final String companyName;
  final String profilePicture;
  final String userGuidId;
  final int userIntId;
  final int userGroupId;
  final String fullName;
  final String phone;
  final String email;
  final String designation;
  final String regNo;
  final String joinDate;
  UserDataEntities({
    required this.companyId,
    required this.companyName,
    required this.profilePicture,
    required this.userGuidId,
    required this.userIntId,
    required this.userGroupId,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.designation,
    required this.regNo,
    required this.joinDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'companyId': companyId,
      'companyName': companyName,
      'profilePicture': profilePicture,
      'userGuidId': userGuidId,
      'userIntId': userIntId,
      'userGroupId': userGroupId,
      'fullName': fullName,
      'phone': phone,
      'email': email,
      'designation': designation,
      'regNo': regNo,
      'joinDate': joinDate,
    };
  }

  factory UserDataEntities.fromMap(Map<String, dynamic> map) {
    return UserDataEntities(
      companyId: map['companyId'] ?? '',
      companyName: map['companyName'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
      userGuidId: map['userGuidId'] ?? '',
      userIntId: map['userIntId']?.toInt() ?? 0,
      userGroupId: map['userGroupId']?.toInt() ?? 0,
      fullName: map['fullName'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      designation: map['designation'] ?? '',
      regNo: map['regNo'] ?? '',
      joinDate: map['joinDate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDataEntities.fromJson(String source) =>
      UserDataEntities.fromMap(json.decode(source));
}
