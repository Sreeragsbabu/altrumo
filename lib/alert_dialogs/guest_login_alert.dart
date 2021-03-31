import 'package:demo_altrumo/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GuestLoginAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Text('Confirm Login!!!!'),
      content: Text('Login is required for further process.'),
      actions: <Widget>[
        FlatButton(
          color: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Text('Login'),
          onPressed: () {
            Navigator.of(context)
                .pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));// Dismiss alert dialog
          },
        ),
        FlatButton(
          color: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context)
                .pop(); // Dismiss alert dialog
          },
        ),
      ],
    );
  }
}
