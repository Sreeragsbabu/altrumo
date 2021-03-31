// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.role,
    this.firstName,
    this.middleName,
    this.lastName,
    this.uhid,
    this.userId,
    this.token,
  });

  String role;
  String firstName;
  String middleName;
  String lastName;
  String uhid;
  String userId;
  String token;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    role: json["role"],
    firstName: json["firstName"],
    middleName: json["middleName"],
    lastName: json["lastName"],
    uhid: json["uhid"],
    userId: json["userId"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "role": role,
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "uhid": uhid,
    "userId": userId,
    "token": token,
  };
}
