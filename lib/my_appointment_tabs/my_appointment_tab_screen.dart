import 'package:flutter/material.dart';
import 'package:demo_altrumo/my_appointment_tabs/past_screen.dart';
import 'package:demo_altrumo/my_appointment_tabs/upcoming_appointment_screen.dart';
import 'package:demo_altrumo/screens/main_drawer.dart';

class MyAppointmentTabScreen extends StatefulWidget {

  @override
  _MyAppointmentTabScreenState createState() => _MyAppointmentTabScreenState();
}

class _MyAppointmentTabScreenState extends State<MyAppointmentTabScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
            title: Text("My Appointments"),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(56),
                child: Material(
                  borderOnForeground: true,
                  child: TabBar(
                    labelColor: Colors.blue,
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(text: "UPCOMING"),
                      Tab(text: "PAST",)
                    ],
                  ),
                ),
              ),
            ),
            drawer: Drawer(
              child: MainDrawer(),
            ),
            body: TabBarView(
              children: [
                UpcomingScreen(),
                PastScreen()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Do you really want to exit the app"),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text("No")),
            FlatButton(onPressed: (){
              Navigator.pop(context, true);
            }, child: Text("Yes"))
          ],
        ));
  }
}
