import 'package:demo_altrumo/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Text('Confirm Logout'),
      content: Text('Are you sure you want to Logout?'),
      actions: <Widget>[
        FlatButton(
          color: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Text('No'),
          onPressed: () {
            Navigator.of(context).pop(); // Dismiss alert dialog
          },
        ),
        FlatButton(
          color: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Text('Yes'),
          onPressed: () async{
            //deleteData();
            Navigator.of(context).pop();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('isLoggedIn');
            prefs.remove('displayName');
            prefs.remove('token');
            prefs.remove('uhid');
            prefs.remove('userId');
            prefs.remove('hospitalName');
            prefs.remove('hospitalId');
            prefs.remove('hospitalLocation');

            Navigator.of(context).pushAndRemoveUntil(
              // the new route
              MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen(),
              ),

                  (Route route) => false,
            );// Dismiss alert dialog
          },
        ),
      ],
    );
  }
}
