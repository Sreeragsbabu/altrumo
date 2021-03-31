import 'package:flutter/cupertino.dart';
import 'dart:convert';

List<Patients> patientsFromJson(String str) => List<Patients>.from(json.decode(str).map((x) => Patients.fromJson(x)));

String patientsToJson(List<Patients> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class Patients{
  String name;

  Patients({
      this.name});

  factory Patients.fromJson(Map<String, dynamic> json) => Patients(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };

  /*static List<Patients> getPatients() => [
    Patients("Jim", "Self", 35, 60, "5'7\""),
    Patients("John", "Father", 65, 65, "5'7\""),
    Patients("Jacob", "Son", 15, 20, "5'7\""),
    Patients("Jeny", "Mother", 55, 55, "5'7\""),
    Patients("Joe", "Brother", 25, 65, "5'7\""),

  ];*/

}