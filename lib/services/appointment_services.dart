import 'dart:convert';
import 'package:demo_altrumo/alert_dialogs/appointment_confirm_alert.dart';
import 'package:demo_altrumo/appointment_models/apointment_response.dart';
import 'package:demo_altrumo/appointment_models/doctors.dart';
import 'package:demo_altrumo/appointment_models/past_appointments.dart';
import 'package:demo_altrumo/appointment_models/specialities.dart';
import 'package:demo_altrumo/appointment_models/time_slots.dart';
import 'package:demo_altrumo/appointment_models/upcoming_appointmets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:demo_altrumo/utils/api_links.dart';

class AppointmentServices {

  static const String specialities = '${APILinks.hisServerUrl}portal/departments';
  static const String consultants = '${APILinks.hisServerUrl}portal/consultant';
  static const String timeSlots = '${APILinks.hisServerUrl}portal/consultant/availability';
  static const String createAppointment = '${APILinks.hisServerUrl}portal/appointment/create';
  static const String getAppointments = '${APILinks.hisServerUrl}portal/patient/appointments';

  static Future<List<Specialities>> getSpecialities(
      String token, String id) async {
    try {
      var endpointUrl = specialities;
      Map<String, String> queryParams = {
        'organizationId': id,
      };
      String queryString = Uri(queryParameters: queryParams).query;
      var requestUrl = endpointUrl + '?' + queryString;
      var response = await http.get(requestUrl, headers: {
        HttpHeaders.authorizationHeader: "Bearer " + token,
      });

      print("success");
      print(response.statusCode);
      print("Bearer " + token);
      if (response.statusCode == 200) {
        final List<Specialities> specialities =
            specialitiesFromJson(response.body);
        return specialities;
      } else {
        return List<Specialities>();
      }
    } catch (e) {
      return List<Specialities>();
    }
  }

  static Future<List<SpecDoctors>> getDoctors(String token, String id) async {
    try {
      var endpointUrl = consultants;
      Map<String, String> queryParams = {
        'departmentId': id,
      };
      String queryString = Uri(queryParameters: queryParams).query;
      var requestUrl = endpointUrl + '?' + queryString;
      var response = await http.get(requestUrl, headers: {
        HttpHeaders.authorizationHeader: "Bearer " + token,
      });

      print("success");
      print(response.statusCode);
      print("Bearer " + token);
      if (response.statusCode == 200) {
        final List<SpecDoctors> doctors = specDoctorsFromJson(response.body);
        return doctors;
      } else {
        return List<SpecDoctors>();
      }
    } catch (e) {
      return List<SpecDoctors>();
    }
  }

  static Future<List<SpecDoctors>> getAllConsultants(String token, String id) async {
    try {
      var endpointUrl = consultants;
      Map<String, String> queryParams = {
        'organizationId': id,
      };
      print(id);
      String queryString = Uri(queryParameters: queryParams).query;
      var requestUrl = endpointUrl + '?' + queryString;
      var response = await http.get(requestUrl, headers: {
        HttpHeaders.authorizationHeader: "Bearer " + token,
      });

      print("success");
      print(response.statusCode);
      print("Bearer " + token);
      if (response.statusCode == 200) {
        final List<SpecDoctors> doctors = specDoctorsFromJson(response.body);
        return doctors;
      } else {
        return List<SpecDoctors>();
      }
    } catch (e) {
      return List<SpecDoctors>();
    }
  }


  static Future<List<TimeSlots>> getTimeSlots(String token, String consultantId,
      String departmentId, String date) async {
    try {
      var endpointUrl =
          timeSlots;
      Map<String, String> queryParams = {
        'consultantId': consultantId,
        'departmentId': departmentId,
        'date': date,
      };
      String queryString = Uri(queryParameters: queryParams).query;
      var requestUrl = endpointUrl + '?' + queryString;
      var response = await http.get(requestUrl, headers: {
        HttpHeaders.authorizationHeader: "Bearer " + token,
      });

      print("success");
      print(response.statusCode);
      print("Bearer " + token);
      if (response.statusCode == 200) {
        final List<TimeSlots> doctors = timeSlotsFromJson(response.body);
        return doctors;
      } else {
        return List<TimeSlots>();
      }
    } catch (e) {
      return List<TimeSlots>();
    }
  }

  static Future<AppointmentResponse> confirmAppointment(
      String token,
      String uhid,
      String consultandId,
      String deptId,
      String apptDate,
      String time,
      String branchId,
      String userId,
      BuildContext context,
      String hospName,
      String patientName,
      String doctorName,
      String deptName,
      String conType) async {
    Map data = {
      "uhid": uhid,
      "consultantId": consultandId,
      "departmentId": deptId,
      "appointmentDate": apptDate,
      "startTime": time,
      /*"appointmentDate": "2021-03-18",
      "startTime":'12:00 AM',*/
      "branchId": branchId,
      "userId": userId
    };

    String body = json.encode(data);
    try {
      http.Response response = await http.post(
        createAppointment,
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: "Bearer " + token,
        },
        body: body,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("move on");
        Fluttertoast.showToast(msg: "Appointment created");
        showDialog<void>(
          context: context,
          barrierDismissible: true,
          // false = user must tap button, true = tap outside dialog
          builder: (BuildContext dialogContext) {
            return AppointmentConfirmDialog(
              context: context,
              name: patientName,
              date: apptDate,
              // hospitalName: selectedBranch,
              hospitalName: hospName,
              consultantName: doctorName,
              specialityName: deptName,
              time: time,
              imageUrl: "assets/pro_pic.png",
              consultType: conType,
            );
          },
        );
        final String responseString = response.body;
        print(responseString);
        return appointmentResponseFromJson(responseString);
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
        return null;
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e);
    }
  }


  static Future<List<UpcomingAppointments>> getUpcomingAppointments(
      String token,
      String uhid,
      ) async {
    try {
      var endpointUrl =
          getAppointments;
      Map<String, String> queryParams = {
        'uhid': uhid,
        'isUpcoming': "true",
      };
      String queryString = Uri(queryParameters: queryParams).query;
      var requestUrl = endpointUrl + '?' + queryString;
      var response = await http.get(requestUrl, headers: {
        HttpHeaders.authorizationHeader: "Bearer " + token,
      });

      print("success");
      print(response.statusCode);
      print("Bearer " + token);
      if (response.statusCode == 200) {
        final List<UpcomingAppointments> upcomingAppts =
        upcomingAppointmentsFromJson(response.body);
        return upcomingAppts;
      } else {
        return List<UpcomingAppointments>();
      }
    } catch (e) {
      return List<UpcomingAppointments>();
    }
  }

  static Future<List<PastAppointments>> getPastAppointments(
      String token,
      String uhid,
      ) async {
    try {
      var endpointUrl =
          getAppointments;
      Map<String, String> queryParams = {
        'uhid': uhid,
        'isUpcoming': "false",
      };
      String queryString = Uri(queryParameters: queryParams).query;
      var requestUrl = endpointUrl + '?' + queryString;
      var response = await http.get(requestUrl, headers: {
        HttpHeaders.authorizationHeader: "Bearer " + token,
      });

      print("success");
      print(response.statusCode);
      print("Bearer " + token);
      if (response.statusCode == 200) {
        final List<PastAppointments> pastAppts =
        pastAppointmentsFromJson(response.body);
        return pastAppts;
      } else {
        return List<PastAppointments>();
      }
    } catch (e) {
      return List<PastAppointments>();
    }
  }
}


