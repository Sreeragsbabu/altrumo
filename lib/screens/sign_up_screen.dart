import 'package:demo_altrumo/models/sign_up_model.dart';
import 'package:demo_altrumo/services/login_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController userNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController uhidController = new TextEditingController();
  bool _loading;
  bool _isVisible = true;
   String firstname = '';
   String lastname ='';
   String username = '';
   String email = '';
   String password = '';
   String uhid = '';
  
  SignUp signUpResponse;
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
                children: [
                  SizedBox(height: 40.0),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.blue, fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    color: Colors.white,
                    elevation: 10.0,
                    child: TextField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        hintText: "First name",
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
                      controller: lastNameController,
                      decoration: InputDecoration(
                        hintText: "Last name",
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
                      controller: userNameController,
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
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
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
                    height: 30.0,
                  ),
                  Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    color: Colors.white,
                    elevation: 10.0,
                    child: TextField(
                      controller: uhidController,
                      decoration: InputDecoration(
                        hintText: "Uhid",
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
                    height: 50.0,
                  ),
                  customButton("Sign Up"),
                  SizedBox(
                    height:10.0,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

  FlatButton customButton(String buttonLabel) {
    return FlatButton(
      color: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      onPressed: () async{
        _loading = false;
         firstname = firstNameController.text;
         lastname = lastNameController.text;
         username = userNameController.text;
         email = emailController.text;
         password = passwordController.text;
         uhid = uhidController.text;
        /*SharedPreferences prefs = await SharedPreferences.getInstance();
        String token= prefs.getString('token');
        print(token);*/
          print(firstname);
        print(lastname);
        print(username);
        print(email);
        print(password);
        print(uhid);
        print(password);
        doSignUp(firstname,lastname,username,email, password,uhid);
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
              text: 'Already have an account ? ',
              style: TextStyle(fontSize: 16.0)),
          TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print(' Sign up tapped');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              text: 'Sign In ',
              style: TextStyle(color: Colors.blue, fontSize: 16.0))
        ],
      ),
    );
  }

  void doSignUp(String firstname, String lastname, String username, String email, String password, String uhid) async{
   
    SignInServices.registerProcess(firstname, lastname, username, email, password, uhid).then((value) {
      setState(() {
        signUpResponse = value;
        Fluttertoast.showToast(msg: signUpResponse.message);
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    });
  }
}


