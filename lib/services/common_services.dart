import 'package:demo_altrumo/models/DeptDoctors.dart';
import 'package:demo_altrumo/models/hospitals.dart';
import 'package:demo_altrumo/models/upcoming_appointments.dart';
import 'package:demo_altrumo/models/past_appointments.dart';
import 'package:demo_altrumo/utils/api_links.dart';
import 'package:http/http.dart' as http;
import 'package:demo_altrumo/models/doctors.dart';
import 'package:demo_altrumo/models/departments.dart';
import 'dart:io';


class HospitalLocationServices{
  static const String organisations = '${APILinks.hisServerUrl}portal/organizations';
  static Future<List<Hospitals>> getHospitals(String token) async{
    try{
      final response = await http.get(organisations, headers: {
        HttpHeaders.authorizationHeader: "Bearer "+ token,
      });
      print(response.statusCode);
      print("Bearer "+ token);
      if(response.statusCode==200){
        final List<Hospitals> hospitals = hospitalsFromJson(response.body);
        return hospitals;
      }
      else{
        return List<Hospitals>();
      }
    }catch(e){
      return List<Hospitals>();
    }
  }
}