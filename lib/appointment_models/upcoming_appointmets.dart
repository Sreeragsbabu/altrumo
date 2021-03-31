// To parse this JSON data, do
//
//     final upcomingAppointments = upcomingAppointmentsFromJson(jsonString);

import 'dart:convert';

List<UpcomingAppointments> upcomingAppointmentsFromJson(String str) => List<UpcomingAppointments>.from(json.decode(str).map((x) => UpcomingAppointments.fromJson(x)));

String upcomingAppointmentsToJson(List<UpcomingAppointments> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UpcomingAppointments {
  UpcomingAppointments({
    this.eventId,
    this.appointmentDate,
    this.startTime,
    this.endTime,
    this.consultantName,
    this.departmentName,
    this.unitName,
    this.referenceNo,
    this.status,
  });

  String eventId;
  DateTime appointmentDate;
  String startTime;
  String endTime;
  String consultantName;
  String departmentName;
  String unitName;
  String referenceNo;
  String status;

  factory UpcomingAppointments.fromJson(Map<String, dynamic> json) => UpcomingAppointments(
    eventId: json["eventId"],
    appointmentDate: DateTime.parse(json["appointmentDate"]),
    startTime: json["startTime"],
    endTime: json["endTime"],
    consultantName: json["consultantName"],
    departmentName: json["departmentName"],
    unitName: json["unitName"],
    referenceNo: json["referenceNo"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "eventId": eventId,
    "appointmentDate": "${appointmentDate.year.toString().padLeft(4, '0')}-${appointmentDate.month.toString().padLeft(2, '0')}-${appointmentDate.day.toString().padLeft(2, '0')}",
    "startTime": startTime,
    "endTime": endTime,
    "consultantName": consultantName,
    "departmentName": departmentName,
    "unitName": unitName,
    "referenceNo": referenceNo,
    "status": status,
  };
}
