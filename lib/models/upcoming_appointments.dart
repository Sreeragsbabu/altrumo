import 'package:flutter/cupertino.dart';
import 'dart:convert';


List<UpcomingAppts> upcomingAppointmentsFromJson(String str) => List<UpcomingAppts>.from(json.decode(str).map((x) => UpcomingAppts.fromJson(x)));

String upcomingAppointmentsToJson(List<UpcomingAppts> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class UpcomingAppts{


  String appointmentid;
  String doctorname;
  String doctorspeciality;
  String patientname;
  String apptdate;
  String appttime;
  String apptlocation;
  String consultationtype;
  String doctorimage;

  UpcomingAppts({
    @required this.appointmentid, @required this.doctorname, @required this.doctorspeciality, @required this.patientname,
    @required this.apptdate, @required this.appttime, @required this.apptlocation, @required this.consultationtype,
    @required this.doctorimage,
  });


  factory UpcomingAppts.fromJson(Map<String, dynamic> json) => UpcomingAppts(
    appointmentid: json["appointmentid"],
    doctorname: json["doctorname"],
    doctorspeciality: json["doctorspeciality"],
    patientname: json["patientname"],
    apptdate: json["apptdate"],
    appttime: json["appttime"],
    apptlocation: json["apptlocation"],
    consultationtype: json["consultationtype"],
    doctorimage: json["doctorimage"],
  );

  Map<String, dynamic> toJson() => {
    "appointmentid": appointmentid,
    "doctorname": doctorname,
    "doctorspeciality": doctorspeciality,
    "patientname": patientname,
    "apptdate": apptdate,
    "appttime": appttime,
    "apptlocation": apptlocation,
    "consultationtype": consultationtype,
    "doctorimage": doctorimage,
  };
}
