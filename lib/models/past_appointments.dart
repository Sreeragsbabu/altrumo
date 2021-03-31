import 'package:flutter/cupertino.dart';
import 'dart:convert';

List<PastAppts> pastAppointmentsFromJson(String str) => List<PastAppts>.from(json.decode(str).map((x) => PastAppts.fromJson(x)));

String pastAppointmentsToJson(List<PastAppts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PastAppts{
  int id;
  String docname;
  String doccategory;
  String patientname;
  String apptdate;
  String appttime;
  String consultationtype;
  String imageurl;

  PastAppts({
    @required this.id,
    @required this.docname,
    @required this.doccategory,
    @required this.patientname,
    @required this.apptdate,
    @required this.appttime,
    @required this.consultationtype,
  @required this.imageurl});

  factory PastAppts.fromJson(Map<String, dynamic> json) => PastAppts(
      id: json["id"],
      docname: json["docname"],
      doccategory: json["doccategory"],
      patientname: json["patientname"],
      apptdate: json["apptdate"],
      appttime: json["appttime"],
      consultationtype: json["consultationtype"],
    imageurl: json["imageurl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "docname": docname,
    "doccategory": doccategory,
    "patientname": patientname,
    "apptdate": apptdate,
    "appttime": appttime,
    "consultationtype": consultationtype,
    "imageurl": imageurl
  };
}