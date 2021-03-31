/*
import 'package:country_code_picker/country_code_picker.dart';
*/
/*import 'package:firebase_auth/firebase_auth.dart';*//*

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/my_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'hospital_location_screen.dart';

import 'profile_screen.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  // String otp1;
  // String otp2;
  // String otp3;
  // String otp4;
  // String otp5;
  // String otp6;
  String smsCode;
  String verificationCode;
  String number;
  String code = "+91";
  //
  // @override
  // void initState() {
  //   myFocusNode2 = FocusNode();
  //   myFocusNode3 = FocusNode();
  //   myFocusNode4 = FocusNode();
  //   myFocusNode5 = FocusNode();
  //   myFocusNode6 = FocusNode();
  // }

  // @override
  // void dispose() {
  //   myFocusNode2.dispose();
  //   myFocusNode3.dispose();
  //   myFocusNode4.dispose();
  //   myFocusNode5.dispose();
  //   myFocusNode6.dispose();
  //   super.dispose();
  // }

  // FocusNode myFocusNode2;
  // FocusNode myFocusNode3;
  // FocusNode myFocusNode4;
  // FocusNode myFocusNode5;
  // FocusNode myFocusNode6;
  final _phoneController = TextEditingController();
  String _phone;
  @override
  Widget build(BuildContext context) {
    void onPhoneNumberChange(
        String number, String internationalizedPhoneNumber, String isoCode) {
      setState(() {
        _phone = internationalizedPhoneNumber;
      });
    }

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 8,
                    ),
                    Text(
                      "Your Phone Number",
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        "Please confirm your country code and enter your phone number",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    SizedBox(
                      height: 36,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 24.0, left: 24.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: CountryCodePicker(
                              flagWidth: 36.0,
                              onChanged: _countrycode,
                              initialSelection: 'IN',
                              favorite: ['+91', 'IN'],
                              showCountryOnly: true,
                            ),
                          ),
                          Container(
                            child: Flexible(
                              child: TextFormField(
                                controller: _phoneController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    counterText: "", hintText: "Enter your number"),
                                onChanged: (val) {
                                  number = code + val;
                                },
                              ),
                            ),
                          ),


                          Text("")

                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setBool('isLoggedIn', true);
                      prefs.setString('displayName', "Guest");
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HospiatlLocationScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Skip Login",style: TextStyle(color: Colors.blue),),
                        SizedBox(width: 10,),
                        Icon(Icons.arrow_forward_ios_outlined,size: 14.0,color: Colors.blue,)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        */
/*await SmsAutoFill().listenForCode;
                        _phoneController.text.length ==10?

                        _submit():Fluttertoast.showToast(msg: "Enter valid phone nummber");*//*

                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 48,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xff1976d2),
                        child: Text(
                          "Next",
                          style: TextStyle(color: Colors.white, fontSize: 14.0),
                        ),
                      ),
                    ),

                    // FlatButton(
                    //   onPressed: () {
                    //     debugPrint("sending");
                    //     _submit();
                    //   },
                    //   child: Text("Next"),
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(0.0)),
                    //   color: Color(0xff1976d2),
                    //   textColor: Colors.white,
                    // )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  */
/*Future<void> _submit() async {
    final PhoneVerificationCompleted verificationSuccess =
        (AuthCredential credential) {
      setState(() {
        print("Verification");
        print(credential.toString());
        print("1");
      });
    };

    *//*
*/
/*final PhoneVerificationFailed phoneVerificationFailed =
        (AuthException exception) {
      print("${exception.message}");
      print("2");
    };*//*
*/
/*

    final PhoneCodeSent phoneCodeSent = (String verId, [int forceCodeResend]) {
      print("3");
      this.verificationCode = verId;
      smsCodeDialog(context).then((value) => print("sign in"));
    };

    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId) {
      print("4");
      this.verificationCode = verId;
    };

    *//*
*/
/*await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.number,
        timeout: const Duration(seconds: 100),
        verificationCompleted: verificationSuccess,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);*//*
*/
/*
  }*//*


  Future<bool> smsCodeDialog(BuildContext context) {
    final focus = FocusNode();
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Verify your number"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Text("Enter the 6 digit code sent via SMS on $number"),
                PinFieldAutoFill(
                  codeLength: 6,
                  onCodeChanged: (pin){
                    if(pin.length == 6){
                      FocusScope.of(context).requestFocus(FocusNode());
                      smsCode = pin;
                    }

                  },
                ),
                // PinInputTextField(
                //   pinLength: 6,
                //   onSubmit: (String pin){
                //     smsCode = pin; //end showDialog()
                //
                //   }, // end onSubmit
                // )
                */
/*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextField(
                        textAlign: TextAlign.center,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        autofocus: true,
                        onChanged: (Value1) {
                          otp1 = Value1;
                          if (otp1.length == 1) {
                            FocusScope.of(context).requestFocus(myFocusNode2);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        textAlign: TextAlign.center,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        focusNode: myFocusNode2,
                        onChanged: (Value2) {
                          otp2 = Value2;
                          if (otp2.length == 1) {
                            FocusScope.of(context).requestFocus(myFocusNode3);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        textAlign: TextAlign.center,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        focusNode: myFocusNode3,
                        onChanged: (Value3) {
                          otp3 = Value3;
                          if (otp3.length == 1) {
                            FocusScope.of(context).requestFocus(myFocusNode4);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        textAlign: TextAlign.center,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        focusNode: myFocusNode4,
                        onChanged: (Value4) {
                          otp4 = Value4;
                          if (otp4.length == 1) {
                            FocusScope.of(context).requestFocus(myFocusNode5);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        textAlign: TextAlign.center,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        focusNode: myFocusNode5,
                        onChanged: (Value5) {
                          otp5 = Value5;
                          if (otp5.length == 1) {
                            FocusScope.of(context).requestFocus(myFocusNode6);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        textAlign: TextAlign.center,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        focusNode: myFocusNode6,
                        onChanged: (Value6) {
                          otp6 = Value6;
                          smsCode = otp1 + otp2 + otp3 + otp4 + otp5 + otp6;
                        },
                      ),
                    ),
                  ],
                )*//*

              ],
            ),
            actions: [
             */
/* FlatButton(
                  onPressed: () async {
                    FirebaseAuth.instance.currentUser().then((user) async {
                      if (user != null) {
                        Navigator.of(context).pop(true);
                       // Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) => ProfileScreen()),
                                (Route<dynamic> route) => false
                        );
                      } else {
                        Fluttertoast.showToast(msg: "New User", gravity: ToastGravity.BOTTOM);
                        Navigator.pop(context, true);
                        signIn();
                      }
                    });
                  },
                  child: Text("Verify")),*//*

              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"))
            ],
          );
        });
  }

  */
/*signIn() {
    AuthCredential phoneAuthCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationCode, smsCode: smsCode);
    FirebaseAuth.instance
        .signInWithCredential(phoneAuthCredential)
        .then((user) =>

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => ProfileScreen()),
                (Route<dynamic> route) => false
        )).catchError((e) => print(e));
  }*//*


  void _countrycode(CountryCode countryCode) {
    code = countryCode.toString();
    print(countryCode.toString());
  }
}
*/
