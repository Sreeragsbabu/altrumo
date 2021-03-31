
import 'package:carousel_slider/carousel_slider.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'phone_auth_screen.dart';
import 'package:demo_altrumo/screens/home.dart';
import 'profile_screen.dart';
import 'package:demo_altrumo/screens/login_screen.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool _isActive= false;
  int _current = 0;
  List imgList = [
    'assets/img_start1.png',
    'assets/img_start2.png',
    'assets/img_start3.png',
    'assets/img_start4.png'
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result =[];
    for(var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 8,
                      ),
                      RichText(
                          text: TextSpan(
                              text: "Al",
                              style: TextStyle(color: Colors.orange, fontSize: 18.0,fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                    text: "trumo",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18.0,fontWeight: FontWeight.bold)),

                              ])),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "DRIVEN BY CARE, POWERED BY DATA",
                        style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                      ),

                    ],
                  ),

                  SizedBox(height: 46,),
                  Column(
                    children: [
                      CarouselSlider(
                          items: imgList.map((imageUrl) {
                            return Builder(builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 50.0),
                                decoration: BoxDecoration(
                                ),
                                child: Image.asset(imageUrl, fit: BoxFit.fitHeight,),
                              );
                            });
                          }).toList(),
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 2),
                            autoPlayAnimationDuration: Duration(milliseconds: 2000),
                            height: 130.0,
                            initialPage: 0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                                _isActive= true;
                              });
                            },
                          )),
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Text("Book an appointment with right doctor and chat online",textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0),),
                    ],
                  )
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map<Widget>(imgList, (index, url) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: EdgeInsets.symmetric(vertical: 30.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index ? Color(0xff1976d2): Colors.grey
                    ),
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Column(
                  children: [
                    FlatButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                       /* Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                MaterialApp(
                                supportedLocales: [Locale('en', 'US')],
                                localizationsDelegates: [CountryLocalizations.delegate],
                                home: PhoneAuthScreen())
                        ));*/
                      },
                      child: Text("Get Started"),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      color: Color(0xff1976d2),
                      textColor: Colors.white,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
