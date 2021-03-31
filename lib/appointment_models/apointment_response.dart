// To parse this JSON data, do
//
//     final appointmentResponse = appointmentResponseFromJson(jsonString);

import 'dart:convert';

AppointmentResponse appointmentResponseFromJson(String str) => AppointmentResponse.fromJson(json.decode(str));

String appointmentResponseToJson(AppointmentResponse data) => json.encode(data.toJson());

class AppointmentResponse {
  AppointmentResponse({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) => AppointmentResponse(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
