import 'package:flutter/cupertino.dart';
import 'dart:convert';

List<Department> departmentFromJson(String str) => List<Department>.from(json.decode(str).map((x) => Department.fromJson(x)));

String departmentToJson(List<Department> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Department{
  String deptname;
  int deptid;

  Department({this.deptname, this.deptid});

  factory Department.fromJson(Map<String, dynamic> json) => Department(
    deptname: json["deptname"],
    deptid: json["deptid"],
  );

  Map<String, dynamic> toJson() => {
    "deptname": deptname,
    "deptid": deptid
  };

 /* static List<Department> getDepartments() => [
    Department("Surgeon", ["John","Smith","Wade"]),
    Department("Dental", ["Anderson", "Peterson", "Rohit"]),
    Department("Orthopedic", ["Adam Gill", "Simmons", "David James"]),
    Department("Neurology", ["Pooja","Andrew Joe", "Steve"]),
    Department("Nutrition", ["Raul", "Saravanan","Lopes"]),
    Department("Cardiology", ["Vrinda","Gilly","Lucas"]),
    Department("Physiotherapy", ["Kane","Robertson","Stein"]),
    Department("Homeopathy", ["Tim","De Jong","Luis"]),
    Department("Anaesthetics", ["Tom","Richardson","Stoinis"]),
  ];*/
}