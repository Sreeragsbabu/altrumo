
import 'dart:convert';
import 'package:flutter/services.dart';


List<DeptDoctors> deptDoctorsFromJson(String str) => List<DeptDoctors>.from(json.decode(str).map((x) => DeptDoctors.fromJson(x)));

String deptDoctorsToJson(List<DeptDoctors> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class DeptDoctors{
  int experience;
  String deptname;
  int likes;
  double rating;
  String employeename;

  DeptDoctors({this.experience, this.deptname, this.likes, this.rating,
      this.employeename});

  factory DeptDoctors.fromJson(Map<String, dynamic> json) => DeptDoctors(
      experience: json["experience"],
      deptname: json["deptname"],
      likes: json["likes"],
      rating: json["rating"],
      employeename:json["employeename"]
  );

  Map<String, dynamic> toJson() => {
    "experience": experience,
    "deptname": deptname,
    "likes": likes,
    "rating": rating,
    "employeename": employeename,
  };
}