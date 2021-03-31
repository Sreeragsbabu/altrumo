import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(
            child: Marquee(
              text: 'You have no new notifications.',
              style: TextStyle(fontWeight: FontWeight.bold),
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 50.0,
              velocity: 100.0,
              pauseAfterRound: Duration(seconds: 1),
              showFadingOnlyWhenScrolling: true,
              fadingEdgeStartFraction: 0.1,
              fadingEdgeEndFraction: 0.1,
              numberOfRounds: 3,
              startPadding: 90.0,
              accelerationDuration: Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOut,
            ),
          ),
        ),
      ),
    );
  }
}
