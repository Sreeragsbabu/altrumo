import 'package:demo_altrumo/models/DeptDoctors.dart';
import 'package:demo_altrumo/models/hospitals.dart';
import 'package:demo_altrumo/models/upcoming_appointments.dart';
import 'package:demo_altrumo/models/past_appointments.dart';
import 'package:http/http.dart' as http;
import 'package:demo_altrumo/models/doctors.dart';
import 'package:demo_altrumo/models/departments.dart';
import 'dart:io';

/*class HospitalLocationServices{
  //static const String url = "https://run.mocky.io/v3/a08c4aac-20f0-4f62-be51-86fe4af7bfcf";
  //static const String url = "http://10.10.10.92:8080/getHospitalBranches";
  static const String url = "http://10.10.10.84:9090/devapp/df/portal/organizations";
  static Future<List<Hospitals>> getHospitals(String token) async{
    try{
      final response = await http.get(url, headers: {
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
}*/

/*class AllDoctorServices{
  //static const String url = "https://run.mocky.io/v3/a08c4aac-20f0-4f62-be51-86fe4af7bfcf";
  static const String url = "http://10.10.10.92:8080/getDoctors";
  static Future<List<Doctors>> getDoctors() async{
    try{
      final response = await http.get(url);
      if(response.statusCode==200){
        final List<Doctors> doctors = doctorsFromJson(response.body);
        return doctors;
      }
      else{
        return List<Doctors>();
      }
    }catch(e){
      return List<Doctors>();
    }
  }
}*/

/*class UpcomingAppointmentServices{
  //static const String url = "https://run.mocky.io/v3/a08c4aac-20f0-4f62-be51-86fe4af7bfcf";
  static const String url = "http://10.10.10.92:8080/getUpcomingAppts";
  static Future<List<UpcomingAppointments>> getUpcomingAppointment() async{
    try{
      final response = await http.get(url);
      if(response.statusCode==200){
        final List<UpcomingAppointments> upcomingAppts = upcomingAppointmentsFromJson(response.body);
        return upcomingAppts;
      }
      else{
        return List<UpcomingAppointments>();
      }
    }catch(e){
      return List<UpcomingAppointments>();
    }
  }

}*/

/*class PastAppointmentServices{
  //static const String url = "https://run.mocky.io/v3/a08c4aac-20f0-4f62-be51-86fe4af7bfcf";
  static const String url = "http://10.10.10.92:8080/getPastAppts";
  static Future<List<PastAppointments>> getPastAppointment() async{
    try{
      final response = await http.get(url);
      if(response.statusCode==200){
        final List<PastAppointments> pastAppts = pastAppointmentsFromJson(response.body);
        return pastAppts;
      }
      else{
        return List<PastAppointments>();
      }
    }catch(e){
      return List<PastAppointments>();
    }
  }

}*/

/*class DepartmentServices{
  //static const String url = "https://run.mocky.io/v3/a08c4aac-20f0-4f62-be51-86fe4af7bfcf";
  static const String url = "http://10.10.10.92:8080/getDepartments";
  static Future<List<Department>> getDepartments() async{
    try{
      final response = await http.get(url);
      if(response.statusCode==200){
        final List<Department> pastAppts = departmentFromJson(response.body);
        return pastAppts;
      }
      else{
        return List<Department>();
      }
    }catch(e){
      return List<Department>();
    }
  }

}*/


/*class DepartmentDoctorServices{

  static Future<List<DeptDoctors>> getDepartmentdoctors(int id) async{
    final String apiUrl = "http://localhost:8080/getdepartmentemployee";
    final response = await http.post(apiUrl,
        body: {
          "deptId": id
        },
    headers: {
      'Content-type': 'application/json; charset=UTF-8',
    });
    if(response.statusCode == 201){
      final String responseString = response.body;
      return deptDoctorsFromJson(responseString);
    }
    else{
      return null;
    }

  }

}*/

