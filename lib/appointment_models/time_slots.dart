// To parse this JSON data, do
//
//     final timeSlots = timeSlotsFromJson(jsonString);

import 'dart:convert';

List<TimeSlots> timeSlotsFromJson(String str) => List<TimeSlots>.from(json.decode(str).map((x) => TimeSlots.fromJson(x)));

String timeSlotsToJson(List<TimeSlots> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimeSlots {
  TimeSlots({
    this.startTime,
    this.endTime,
    this.available,
  });

  String startTime;
  String endTime;
  bool available;

  factory TimeSlots.fromJson(Map<String, dynamic> json) => TimeSlots(
    startTime: json["startTime"],
    endTime: json["endTime"],
    available: json["available"],
  );

  Map<String, dynamic> toJson() => {
    "startTime": startTime,
    "endTime": endTime,
    "available": available,
  };
}
