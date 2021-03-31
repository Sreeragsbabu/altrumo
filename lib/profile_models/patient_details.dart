// To parse this JSON data, do
//
//     final patientDetails = patientDetailsFromJson(jsonString);

import 'dart:convert';

PatientDetails patientDetailsFromJson(String str) => PatientDetails.fromJson(json.decode(str));

String patientDetailsToJson(PatientDetails data) => json.encode(data.toJson());

class PatientDetails {
  PatientDetails({
    this.patientId,
    this.firstName,
    this.middleName,
    this.lastName,
    this.gender,
    this.email,
    this.username,
    this.mobileNo,
    this.dateOfBirth,
    this.age,
    this.uhid,
  });

  int patientId;
  String firstName;
  dynamic middleName;
  String lastName;
  String gender;
  String email;
  dynamic username;
  String mobileNo;
  DateTime dateOfBirth;
  String age;
  String uhid;

  factory PatientDetails.fromJson(Map<String, dynamic> json) => PatientDetails(
    patientId: json["patientId"],
    firstName: json["firstName"],
    middleName: json["middleName"],
    lastName: json["lastName"],
    gender: json["gender"],
    email: json["email"],
    username: json["username"],
    mobileNo: json["mobileNo"],
    dateOfBirth: DateTime.parse(json["dateOfBirth"]),
    age: json["age"],
    uhid: json["uhid"],
  );

  Map<String, dynamic> toJson() => {
    "patientId": patientId,
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "gender": gender,
    "email": email,
    "username": username,
    "mobileNo": mobileNo,
    "dateOfBirth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "age": age,
    "uhid": uhid,
  };
}
