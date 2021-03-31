// To parse this JSON data, do
//
//     final vitals = vitalsFromJson(jsonString);

import 'dart:convert';

List<Vitals> vitalsFromJson(String str) => List<Vitals>.from(json.decode(str).map((x) => Vitals.fromJson(x)));

String vitalsToJson(List<Vitals> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Vitals {
  Vitals({
    this.parameterName,
    this.parameterValue,
    this.parameterValueRange,
    this.enteredDate,
    this.interpretation,
    this.unit,
  });

  String parameterName;
  String parameterValue;
  String parameterValueRange;
  DateTime enteredDate;
  String interpretation;
  String unit;

  factory Vitals.fromJson(Map<String, dynamic> json) => Vitals(
    parameterName: json["parameterName"],
    parameterValue: json["parameterValue"],
    parameterValueRange: json["parameterValueRange"],
    enteredDate: DateTime.parse(json["enteredDate"]),
    interpretation: json["interpretation"],
    unit: json["unit"],
  );

  Map<String, dynamic> toJson() => {
    "parameterName": parameterName,
    "parameterValue": parameterValue,
    "parameterValueRange": parameterValueRange,
    "enteredDate": enteredDate.toIso8601String(),
    "interpretation": interpretation,
    "unit": unit,
  };
}


