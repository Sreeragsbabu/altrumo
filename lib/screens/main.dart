import 'package:flutter/material.dart';

import 'privacy_policy.dart';
import 'start_screen.dart';
import 'terms_of_services.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 8,
                    ),
                    welcomeText(),
                    SizedBox(
                      height: 55,
                    ),
                    logo(),
                    SizedBox(
                      height: 20,
                    ),
                    richText(),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "DRIVEN BY CARE, POWERED BY DATA",
                      style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    longText(),
                    SizedBox(
                      height: 5,
                    ),
                    richText2(context),
                    SizedBox(
                      height: 40,
                    ),
                    agreeContinue(context),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget welcomeText() {
    return Align(
        alignment: Alignment.center,
        child: Text(
          "Welcome to",
          style: TextStyle(color: Colors.black54, fontSize: 16.0),
        ));
  }

  Widget logo() {
    return Container(
        width: 88,
        height: 88,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
                image: AssetImage("assets/altrumo.png"),
                fit: BoxFit.fitHeight)));
  }
}

Widget richText() {
  return RichText(
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
      ]));
}


Widget longText() {
  return Text(
    "Tap \"Agree & Continue\" to accept the Patient",
    style: TextStyle(color: Colors.black54, fontSize: 14.0),
  );
}

Widget richText2(BuildContext context) {
  return RichText(
      text: TextSpan(
          text: "Healthcare",
          style: TextStyle(color: Colors.black54, fontSize: 14.0),
          children: [
        WidgetSpan(
            child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TermsOfServices()));
          },
          child: Text(
            " Terms of Services",
            style: TextStyle(
                color: Color(0xffff9800),
                decoration: TextDecoration.underline,
                fontSize: 14.0),
          ),
        )),
        TextSpan(
            text: " and ",
            style: TextStyle(color: Colors.black54, fontSize: 14.0)),
        WidgetSpan(
            child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()));
          },
          child: Text(
            "Privacy Policy",
            style: TextStyle(
                color: Color(0xffff9800),
                decoration: TextDecoration.underline,
                fontSize: 14.0),
          ),
        )),
      ]));
}

Widget agreeContinue(BuildContext context) {
  /*return  OutlinedButton(
    child: Text('Woolha.com'),
    ,
    onPressed: () {
      print('Pressed');
    },
  );*/
  return Padding(
    padding: const EdgeInsets.only(bottom: 40.0),
    child: OutlinedButton(
        child: Text(
          "Agree & Continue",
          style: TextStyle(
              color: Color(0xff1976d2),
              fontSize: 22.0,
              fontWeight: FontWeight.w500),
        ),

        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.blue, width: 2),
        ),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StartScreen()),
          );
        },
        //shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
    ),
  );
 /* return Padding(
    padding: const EdgeInsets.only(bottom: 40.0),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StartScreen()),
        );
      },
      child: Text(
        "Agree & Continue",
        style: TextStyle(
            color: Color(0xff1976d2),
            fontSize: 22.0,
            fontWeight: FontWeight.w500),
      ),
    ),
  );*/
}
