import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:demo_altrumo/alert_dialogs/guest_login_alert.dart';
import 'package:demo_altrumo/my_appointment_tabs/my_appointment_tab_screen.dart';
import 'package:flutter/material.dart';

import 'package:demo_altrumo/navigation_tabs/home_tab.dart';
import 'package:demo_altrumo/navigation_tabs/home_tab2.dart';
import 'package:demo_altrumo/navigation_tabs/chat_tab.dart';
import 'package:demo_altrumo/navigation_tabs/my_doc_tab.dart';
import 'package:demo_altrumo/screens/main_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
   int currentIndex;
  HomeScreen({this.currentIndex});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String user;
  GlobalKey _bottomNavigationKey = GlobalKey();
  BuildContext context;

  @override
  void initState() {
    userCheck();
    // TODO: implement initState
    super.initState();
  }
  void userCheck() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user = prefs.getString('displayName');

  }

  final tabs = [
    HomeTab2(),
    MyAppointmentTabScreen(),
    MyDocTab(),
    ChatTab(),

    // ProfileTab()
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: tabs[widget.currentIndex],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xff1976d2),

          ),

          child: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            key: _bottomNavigationKey,
            currentIndex: widget.currentIndex,
            //height: 50,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Image.asset("assets/icons/ic_appts.png",color: Colors.white,
                      width: 24, height: 24),
              label: "My Appts."),

              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/ic_my_doc.png",color: Colors.white,
                    width: 24,
                    height: 24,
                  ),
                  label: "My doctors"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat_rounded),
                  label: "Chat"),

              // Image.asset("assets/icons/ic_home.png", width: 24, height: 24,color: Colors.black,),
              // Image.asset("assets/icons/ic_appts.png",width: 24, height: 24,color: Colors.black54,),
              // Image.asset("assets/icons/ic_my_doc.png",width: 24,height: 24,color: Colors.black,),
              // Image.asset("assets/icons/ic_chats.png", width: 24, height: 24,color: Colors.black,),
            ],

            onTap: (index) {
              if(user =="Guest"){
                showDialog<void>(
                  context: context,
                  barrierDismissible: true,
                  // false = user must tap button, true = tap outside dialog
                  builder: (BuildContext dialogContext) {
                    return GuestLoginAlert();
                  },
                );
              }
              else{
                setState(() {
                  widget.currentIndex = index;
                });
              }

            },
          ),
        ),
      ),
    );
  }
}
