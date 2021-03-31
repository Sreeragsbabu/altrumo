// To parse this JSON data, do
//
//     final specialities = specialitiesFromJson(jsonString);

import 'dart:convert';

List<Specialities> specialitiesFromJson(String str) => List<Specialities>.from(json.decode(str).map((x) => Specialities.fromJson(x)));

String specialitiesToJson(List<Specialities> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Specialities {
  Specialities({
    this.id,
    this.code,
    this.value,
  });

  int id;
  String code;
  String value;

  factory Specialities.fromJson(Map<String, dynamic> json) => Specialities(
    id: json["id"],
    code: json["code"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "value": value,
  };
}
