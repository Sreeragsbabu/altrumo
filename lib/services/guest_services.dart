

import 'package:demo_altrumo/appointment_models/doctors.dart';
import 'package:demo_altrumo/appointment_models/specialities.dart';
import 'package:demo_altrumo/utils/api_links.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class GuestServices{
  static const String specialities = '${APILinks.hisServerUrl}mobile/departments';
  static const String consultants = '${APILinks.hisServerUrl}mobile/consultant';

  static Future<List<SpecDoctors>> getAllConsultants(String id) async {
    try {
      var endpointUrl = consultants;
      Map<String, String> queryParams = {
        'organizationId': id,
      };
      print(id);
      String queryString = Uri(queryParameters: queryParams).query;
      var requestUrl = endpointUrl + '?' + queryString;
      var response = await http.get(requestUrl);

      print("success");
      print(response.statusCode);
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

  static Future<List<Specialities>> getSpecialities(String id) async {
    try {
      var endpointUrl = specialities;
      Map<String, String> queryParams = {
        'organizationId': id,
      };
      String queryString = Uri(queryParameters: queryParams).query;
      var requestUrl = endpointUrl + '?' + queryString;
      var response = await http.get(requestUrl);

      print("success");
      print(response.statusCode);
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

  static Future<List<SpecDoctors>> getSpecialityConsultants(String id) async {
    try {
      var endpointUrl = consultants;
      Map<String, String> queryParams = {
        'departmentId': id,
      };
      String queryString = Uri(queryParameters: queryParams).query;
      var requestUrl = endpointUrl + '?' + queryString;
      var response = await http.get(requestUrl);

      print("success");
      print(response.statusCode);
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
}