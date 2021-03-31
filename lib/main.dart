
import 'dart:io';

import 'package:country_code_picker/country_localizations.dart';
import 'package:demo_altrumo/screens/profile_screen.dart';
import 'package:demo_altrumo/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:demo_altrumo/screens/phone_auth_screen.dart';
import 'my_appointment_tabs/my_appointment_tab_screen.dart';
import 'screens/home.dart';
import 'screens/splash_screen.dart';
import 'screens/appointment_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/start_screen.dart';
import 'drawer_screens/family_members_screen.dart';
import 'package:http/http.dart' as http;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLoggedIn = prefs.getBool('isLoggedIn');
  print(isLoggedIn);
  //var fullName = preferences.getString('full_name');
  //HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp(isLoggedIn: isLoggedIn,));
}
/*class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host,
          int port) => true;
  }
}*/


class MyApp extends StatelessWidget {
  final isLoggedIn;

  const MyApp({Key key, this.isLoggedIn}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff1976d2),
        //primarySwatch: Color(0xff1976d2),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      supportedLocales: [Locale('en', 'US')],
      localizationsDelegates: [CountryLocalizations.delegate],
      routes: {
        "/profile": (_) => new ProfileScreen(),
        "/home": (_) => new HomeScreen(),
        "/my_appointment": (_) => new MyAppointmentTabScreen(),
      },
    // home: ProfileScreen(),
    home: isLoggedIn == null? SplashScreen():HomeScreen(currentIndex: 0,),
    );
  }
}


