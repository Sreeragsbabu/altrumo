import 'package:demo_altrumo/screens/sign_up_screen.dart';
import 'package:demo_altrumo/services/login_services.dart';
import 'package:flutter/material.dart';
import 'package:demo_altrumo/models/login_model.dart';
import 'package:demo_altrumo/screens/hospital_location_screen.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'home.dart';
import 'profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginModel _user;
  TextEditingController nameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool _loading;
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.0),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Welcome to",
                        style: TextStyle(color: Colors.black54, fontSize: 16.0),
                      )),
                  SizedBox(height: 16.0),
                  Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              image: AssetImage("assets/altrumo.png"),
                              fit: BoxFit.fitHeight))),
                  SizedBox(height: 8.0),
                  RichText(
                      text: TextSpan(
                          text: "Al",
                          style: TextStyle(color: Colors.orange, fontSize: 18.0,fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: "trumo",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18.0,fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: " PATIENTCARE",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold))
                          ])),
                  SizedBox(height: 16.0),
                  /*Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              image: AssetImage("assets/altrumo.png"),
                              fit: BoxFit.fitHeight))),*/
                  Text(
                    "Sign In",
                    style: TextStyleSign(),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    color: Colors.white,
                    elevation: 10.0,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "User name",
                        hintStyle: TextStyle(
                            color: Colors.black26, fontWeight: FontWeight.w500),
                        fillColor: Colors.blue,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    color: Colors.white,
                    elevation: 10.0,
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: Colors.black26, fontWeight: FontWeight.w500),
                          fillColor: Colors.blue,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              )),
                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                _isVisible = !_isVisible;
                              });

                            },
                            icon: _isVisible? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                          )),
                      obscureText: _isVisible ? true : false,
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  customButton("Sign In"),
                  SizedBox(
                    height:10.0,
                  ),
                  FlatButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setBool('isLoggedIn', true);
                      prefs.setString('displayName', "Guest");
                      prefs.setString('token', 'tokenGuest');
                      prefs.setString('hospitalName', 'Ghassan N. Pharaon');
                      prefs.setInt('hospitalId', 2);
                      prefs.setString('hospitalLocation', 'IHX');
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => HomeScreen(
                                currentIndex: 0,
                              )),
                              (Route<dynamic> route) => false);
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HospiatlLocationScreen()));*/
                    },
                    child: Text(
                      "Skip Sign in",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customRichText(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void doLogin(String name, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SignInServices.loginProcess(name, password).then((value) => setState(
          () {
            _user = value;
            _loading = false;

            prefs.setBool('isLoggedIn', true);
            prefs.setString('displayName', value.firstName.toString());
            prefs.setString('token', value.token);
            prefs.setString('uhid', value.uhid.toString());
            prefs.setString('userId', value.userId.toString());
            prefs.setString('hospitalName', 'Ghassan N. Pharaon');
            prefs.setInt('hospitalId', 2);
            prefs.setString('hospitalLocation', 'IHX');
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen(
                      currentIndex: 0,
                    )),
                    (Route<dynamic> route) => false);
            /*Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HospiatlLocationScreen()),
                    (Route<dynamic> route) => false);*/
          },
        ));


  }

 /* Future<LoginModel> loginProcess(String name, String password) async {
    Map data = {"username": name, "password": password, "userType": "patient"};

    String body = json.encode(data);
    try {
      http.Response response = await http.post(
        "http://10.10.10.84:9090/devapp/df/jwtlogin",
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("move on");
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
  }*/

  TextStyle TextStyleSign() => TextStyle(
      color: Colors.blue, fontSize: 22.0, fontWeight: FontWeight.bold);

  FlatButton customButton(String buttonLabel) {
    return FlatButton(
      color: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      onPressed: () {
        _loading = false;
        final String name = nameController.text;
        final String password = passwordController.text;

        doLogin(name, password);
      },
      child: Text(
        buttonLabel,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  RichText customRichText() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black54,
        ),
        children: [
          TextSpan(
              text: 'Don\'t have an account ? ',
              style: TextStyle(fontSize: 16.0)),
          TextSpan(
               recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print(' Sign up tapped');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
              text: 'Sign Up ',
              style: TextStyle(color: Colors.blue, fontSize: 16.0))
        ],
      ),
    );
  }
}
