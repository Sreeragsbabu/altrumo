// To parse this JSON data, do
//
//     final specDoctors = specDoctorsFromJson(jsonString);

import 'dart:convert';

List<SpecDoctors> specDoctorsFromJson(String str) => List<SpecDoctors>.from(json.decode(str).map((x) => SpecDoctors.fromJson(x)));

String specDoctorsToJson(List<SpecDoctors> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpecDoctors {
  SpecDoctors({
    this.id,
    this.employeeCode,
    this.employeeName,
    this.availableDays,
    this.departmentName,
    this.qualification,
    this.address,
    this.departmentId,
  });

  int id;
  String employeeCode;
  String employeeName;
  String availableDays;
  String departmentName;
  dynamic qualification;
  String address;
  int departmentId;

  factory SpecDoctors.fromJson(Map<String, dynamic> json) => SpecDoctors(
    id: json["id"],
    employeeCode: json["employeeCode"],
    employeeName: json["employeeName"],
    availableDays: json["availableDays"],
    departmentName: json["departmentName"],
    qualification: json["qualification"],
    address: json["address"],
    departmentId: json["departmentId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employeeCode": employeeCode,
    "employeeName": employeeName,
    "availableDays": availableDays,
    "departmentName": departmentName,
    "qualification": qualification,
    "address": address,
    "departmentId": departmentId,
  };
}
