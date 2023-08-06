import 'dart:convert';

class LoginEntities {
  final String userName;
  final String password;
  final String deviceToken;
  final String utc;
  LoginEntities({
    required this.userName,
    required this.password,
    required this.deviceToken,
    required this.utc,
  });

  Map<String, dynamic> toMap() {
    return {
      'UserName': userName,
      'Password': password,
      'DeviceToken': deviceToken,
      'Utc': utc,
    };
  }

  factory LoginEntities.fromMap(Map<String, dynamic> map) {
    return LoginEntities(
      userName: map['UserName'],
      password: map['Password'],
      deviceToken: map['DeviceToken'],
      utc: map['Utc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginEntities.fromJson(String source) =>
      LoginEntities.fromMap(json.decode(source));
}
