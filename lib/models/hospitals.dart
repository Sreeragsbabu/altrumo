/*
import 'package:flutter/cupertino.dart';
import 'dart:convert';


List<Hospitals> hospitalsFromJson(String str) => List<Hospitals>.from(json.decode(str).map((x) => Hospitals.fromJson(x)));

String hospitalsToJson(List<Hospitals> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Hospitals{
  String name;
  String code;
  int id;

  Hospitals({ @required this.name, @required this.code, @required this.id});


  factory Hospitals.fromJson(Map<String, dynamic> json) => Hospitals(
    name: json["name"],
    id: json["id"],
    code: json["code"]
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "code": code,
  };
  }
*/

// To parse this JSON data, do
//
//     final hospitals = hospitalsFromJson(jsonString);

// To parse this JSON data, do
//
//     final hospitals = hospitalsFromJson(jsonString);

// To parse this JSON data, do
//
//     final hospitals = hospitalsFromJson(jsonString);

import 'dart:convert';

List<Hospitals> hospitalsFromJson(String str) => List<Hospitals>.from(json.decode(str).map((x) => Hospitals.fromJson(x)));

String hospitalsToJson(List<Hospitals> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Hospitals {
  Hospitals({
    this.id,
    this.code,
    this.name,
    this.address,
    this.phone1,
    this.phone2,
  });

  int id;
  String code;
  String name;
  String address;
  String phone1;
  String phone2;

  factory Hospitals.fromJson(Map<String, dynamic> json) => Hospitals(
    id: json["id"],
    code: json["code"],
    name: json["name"],
    address: json["address"],
    phone1: json["phone1"],
    phone2: json["phone2"] == null ? null : json["phone2"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "address": address,
    "phone1": phone1,
    "phone2": phone2 == null ? null : phone2,
  };
}



