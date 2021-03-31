import 'dart:convert';
import 'package:demo_altrumo/models/sign_up_model.dart';
import 'package:demo_altrumo/profile_models/vitals.dart';
import 'package:demo_altrumo/utils/api_links.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:demo_altrumo/models/login_model.dart';
import 'package:demo_altrumo/profile_models/patient_details.dart';
import 'dart:io';



class SignInServices{
  static const String signin = '${APILinks.hisServerUrl}jwtlogin';
  static const String signup = '${APILinks.hisServerUrl}signup/patient';

  static Future<LoginModel> loginProcess(String name, String password) async {
    Map data = {"username": name, "password": password, "userType": "patient"};
    String body = json.encode(data);
    try {
      http.Response response = await http.post(
        signin,
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("Login Success");
        Fluttertoast.showToast(msg: "Login Succesfully");

        final String responseString = response.body;
        print(responseString);
        return loginModelFromJson(responseString);
      } else {
        Fluttertoast.showToast(msg: "Invalid user");
        return null;
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  static Future<SignUp> registerProcess(
      String fName,
      String lName,
      String username,
      String email,
      String password,
      String uhid) async {
    Map data = {
      "firstName": fName,
      "lastName": lName,
      "loginId": username,
      "emailid": email,
      "password": password,
      "crNo": uhid,
    };

    String body = json.encode(data);
    try {
      http.Response response = await http.post(
        signup,
        body: body,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("move on");
        Fluttertoast.showToast(msg: "Patient registered");

        final String responseString = response.body;
        print(responseString);
        return signUpFromJson(responseString);
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
        return null;
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e);
    }
  }
}

class PatientDetailServices {

  static const String patientDetails = '${APILinks.hisServerUrl}portal/patient/details';
  static const String patientVitals = '${APILinks.hisServerUrl}portal/patient/vitals';
  static Future<PatientDetails> getPatientDetails(
      String token,
      String uhid,
      ) async {
    try {
      var endpointUrl =
          patientDetails;
      Map<String, String> queryParams = {
        'uhid': uhid,
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

        final PatientDetails patientDetails =
        patientDetailsFromJson(response.body);
        return patientDetails;
      } else {
        return PatientDetails();
      }
    } catch (e) {
      return PatientDetails();
    }
  }


  static Future<List<Vitals>> getPatientVitals(
      String token,
      String uhid,
      ) async {
    try {
      var endpointUrl =
          patientVitals;
      Map<String, String> queryParams = {
        'uhid': uhid,
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

        final List<Vitals> patientVitals =
        vitalsFromJson(response.body);
        return patientVitals;
      } else {
        return List<Vitals>();
      }
    } catch (e) {
      return List<Vitals>();
    }
  }
}