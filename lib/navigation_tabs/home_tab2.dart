import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo_altrumo/alert_dialogs/guest_login_alert.dart';
import 'package:demo_altrumo/alert_dialogs/logout_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:demo_altrumo/screens/add_member_screen.dart';
import 'package:demo_altrumo/screens/appointment_screen.dart';
import 'package:demo_altrumo/screens/main_drawer.dart';
import 'package:demo_altrumo/screens/my_doctor_list_screen.dart';
import 'file:///D:/flutter_demo_projects/demo_altrumo/lib/healthpackage/health_check_package_screen.dart';
import 'package:demo_altrumo/screens/find_services.dart';
import 'package:demo_altrumo/screens/lab_reports_screen.dart';
import 'package:demo_altrumo/screens/symptom_checker_screen.dart';
import 'package:demo_altrumo/screens/payment_screen.dart';
import 'package:demo_altrumo/screens/ehr_screen.dart';
import 'package:demo_altrumo/my_appointment_tabs/my_appointment_tab_screen.dart';
import 'package:demo_altrumo/screens/notification_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:demo_altrumo/screens/profile_screen.dart';
import 'package:demo_altrumo/screens/settings_screen.dart';
import 'package:demo_altrumo/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo_altrumo/screens/hospital_location_screen.dart';
import 'package:demo_altrumo/models/hospitals.dart';
import 'package:demo_altrumo/alert_dialogs/sos_emergency_alert_dialog.dart';
import 'package:demo_altrumo/models/members.dart';
import 'package:demo_altrumo/drawer_screens/family_members_screen.dart';
import 'package:demo_altrumo/screens/login_screen.dart';
import 'package:demo_altrumo/appointment_screens/patient.dart';
class HomeTab2 extends StatefulWidget {
  final String userName;

  HomeTab2( {Key key, this.userName}) : super(key: key);
  @override
  _HomeTab2State createState() => _HomeTab2State();
}
class _HomeTab2State extends State<HomeTab2> {
  /*final List<Members> members= [];
  void _addNewMember(String name, String age, String dob, String gender, String relation){
    final newMembers = Members(name: name, age: age, dob: dob, gender: gender, relation: relation);
    setState(() {
      members.add(newMembers);
    });
  }*/
  String user;
  bool _isActive = false;
  int _current = 0;
  List imgList = [
    'assets/home_1.jpg',
    'assets/home_2.jpg',
    'assets/home_3.jpg',
    'assets/home_4.jpg'
  ];
  String displayName ="";
  String displayHospitalName ="";
  String displayHospitalLocation ="";

  @override
  void initState() {
    loadName();
    userCheck();
  }
  void userCheck() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
     user = prefs.getString('displayName');

  }

  /*//Map name = {'name': ''};

  @override
  void initState(){
    CollectionReference collectionReference = Firestore.instance.collection('patient_data');
    collectionReference.snapshots().listen((snapshot) {
      setState(() {
        //List documents;
        name = snapshot.documents[0].data;
        displayName = dispName;
      });
    });
  }*/

  loadName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dispName = prefs.getString('displayName');
    var hospName = prefs.getString('hospitalName');
    var hospLocation = prefs.getString('hospitalLocation');
    setState(() {
      displayName = dispName;
      displayHospitalName = hospName;
      displayHospitalLocation= hospLocation;
    });

  }
  /*deleteData() async{
    CollectionReference collectionReference = Firestore.instance.collection('patient_data');
    QuerySnapshot querySnapshot = await collectionReference.getDocuments();
    querySnapshot.documents[0].reference.delete();
  }*/
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Stack(
                //   children: [
                //     Container(
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(20.0)
                //       ),
                //         width: 40,
                //         height: 40,
                //         ),
                //     Container(
                //         width: 38,
                //         height: 38,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10.0),
                //             image: DecorationImage(
                //                 image: AssetImage("assets/altrumo.png"),
                //                 fit: BoxFit.fitHeight))),
                //   ],
                // ),
                Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                            image: AssetImage("assets/altrumo.png"),
                            fit: BoxFit.fitHeight))),
                SizedBox(width: 8.0,),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HospiatlLocationScreen()));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(child: Text(displayHospitalName, style: TextStyle(fontSize: 15.0),)),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                  ),
                ),
                /*Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HospiatlLocationScreen()));
                    },
                    child: Text(displayHospitalName,style: TextStyle(fontSize: 15.0),),
                  ),
                )*/
                /*Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(displayHospitalName, style: TextStyle(fontSize: 15.0),),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HospiatlLocationScreen()));
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(displayHospitalLocation, style: TextStyle(fontSize: 14.0),),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                    ],
                  ),
                )*/
              ],
            ),
            //title: Text("Altrumo"),
            actions: [
              IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
                },
                icon: Icon(Icons.notifications_none,color: Colors.white,),),
              IconButton(
                onPressed: (){
                  logoutAlert(context);
                },
                icon: Image.asset("assets/logout.png",color: Colors.white,width: 20.0,height: 20.0,),)
              /*PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {'Logout', 'Settings'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              )*/
            ],
          ),
          drawer: Drawer(
            child: MainDrawer(),
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Column(
                children: [
                  SizedBox(height: 10.0,),
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: <Widget>[

                      CarouselSlider(
                          items: imgList.map((imageUrl) {
                            return Builder(builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(),
                                child: Image.asset(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              );
                            });
                          }).toList(),
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(milliseconds: 2000),
                            height: MediaQuery.of(context).size.height / 4,
                            initialPage: 0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                                _isActive = true;
                              });
                            },
                          )),
                      /*Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/home_1.jpg"),
                              fit: BoxFit.fill),
                        ),
                      ),*/
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        height: 80,
                      ),
                      //Icon(Icons.play_circle_outline,color: Colors.white,size: 100,),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Hi",
                            style: TextStyle(
                                color: Color(0xff1976d2), fontSize: 28.0),
                          ),
                         /* Text(
                            displayName,
                            style: TextStyle(
                                color: Color(0xff1976d2), fontSize: 28.0),
                          ),*/
                          GestureDetector(
                            onTap: () {
                              showDialog<void>(
                                context: context,
                                // false = user must tap button, true = tap outside dialog
                                builder: (BuildContext dialogContext) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12.0)
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          /*Text(name['name'].toString(),style: TextStyle(
                                              color: Color(0xff1976d2),
                                              fontSize: 16.0)),*/
                                          Text(displayName,style: TextStyle(
                                              color: Color(0xff1976d2),
                                              fontSize: 16.0)),
                                          Divider(color: Colors.grey,),
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.pop(context);
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => FamilyMembersScreen()));
                                            },
                                            child: Text('+ ADD MEMBER',style: TextStyle(
                                                color: Color(0xffff9800),
                                                fontSize: 16.0)),
                                          ),
                                        ],
                                      ),

                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    Text(displayName,
                                        style: TextStyle(
                                            color: Color(0xff1976d2),
                                            fontSize: 32.0)),
                                    /*Text(name['name'].toString(),
                                        style: TextStyle(
                                            color: Color(0xff1976d2),
                                            fontSize: 32.0)),*/
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xff1976d2),
                                    )
                                  ],
                                )),
                          )
                        ],
                      )),
                  Expanded(
                    child: StaggeredGridView.count(
                      crossAxisCount: 2,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      children: [
                        InkWell(
                          onTap: () {
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SelectPatient()));
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentScreen()));
                            }

                          },
                          child: Container(
                              child: MyItems("assets/appointment.png",
                                  "Book an Appointment", 0xffffffff)),
                        ),

                        InkWell(
                            onTap: () {
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => EhrScreen()));
                              }

                            },
                            child: Container(
                                child: MyItems("assets/ehr.png", "PHR", 0xffffffff))),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyDoctorsListScreen()));
                          },
                            child: Container(
                                child: MyItems(
                                    "assets/all_doctors.png", "All Doctors", 0xffffffff))),
                        InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => FindServicesScreen()));
                            },
                            child: Container(
                                child: MyItems("assets/services.png", "Find Services",
                                    0xffffffff))),
                        InkWell(
                            onTap: () {
                             Navigator.push(context, MaterialPageRoute(builder: (context) => HealthCheckPackageScreen(hospitalName: displayHospitalName,hospitalLocation: displayHospitalLocation,)));
                            },
                            child: Container(
                                child: MyItems("assets/doctors.png",
                                    "Health Checkup", 0xffffffff))),

                        InkWell(
                            onTap: (){
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => LabReportScreen()));
                              }

                            },
                            child: Container(
                                child: MyItems("assets/health_checkup.png",
                                    "Lab Reports", 0xffffffff))),
                        // InkWell(
                        //     onTap: (){
                        //       Navigator.push(context, MaterialPageRoute(builder: (context) => SymptomCheckerScreen()));
                        //     },
                        //     child: Container(
                        //         child: MyItems("assets/symptom_checker.png",
                        //             "Symptom Checker", 0xffffffff))),
                        InkWell(
                            onTap: (){
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
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: true,
                                  // false = user must tap button, true = tap outside dialog
                                  builder: (BuildContext dialogContext) {
                                    return SosEmergencyAlertDialog();
                                  },
                                );
                              }

                            },
                            child: Container(
                                child: MyItems("assets/emergency.png",
                                    "Emergency SOS", 0xffffffff))),

                        InkWell(
                            onTap: (){
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen()));
                              }

                            },
                            child: Container(
                                child: MyItems("assets/payment.png", "Make a Payment",
                                    0xffffffff))),
                      ],
                      staggeredTiles: [
                        StaggeredTile.extent(1, 70.0), //appointment
                        StaggeredTile.extent(1, 70.0), //ehr
                        StaggeredTile.extent(1, 70.0), //healthcheckup
                        StaggeredTile.extent(1, 70.0), //find services
                        StaggeredTile.extent(1, 70.0),
                        StaggeredTile.extent(1, 70.0),
                        StaggeredTile.extent(1, 70.0),
                        StaggeredTile.extent(1, 70.0),
                        //StaggeredTile.extent(1, 70.0),
                        //StaggeredTile.extent(1, 70.0)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material MyItems(String imageUrl, String heading, int color) {
    return Material(
      color: Color(color),
      elevation: 14.0,
      shadowColor: Color(0x802196f3),
      borderRadius: BorderRadius.circular(12.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Material(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Container(
                    width: 30,
                    height: 30,
                    child: Image.asset(imageUrl),
                  )),
              SizedBox(
                width: 10,
              ),
              Flexible(
                  child: Text(
                heading,
                style: TextStyle(color: Color(0xff1976d2), fontSize: 16.0),
              )),
            ],
          ),
        ),
      ),
    );
  }

  // void handleClick(String value) {
  //   switch (value) {
  //     case 'Logout':
  //       showDialog<void>(
  //         context: context,
  //         barrierDismissible: true,
  //         // false = user must tap button, true = tap outside dialog
  //         builder: (BuildContext dialogContext) {
  //           return AlertDialog(
  //             title: Text('Confirm Logout'),
  //             content: Text('Are you sure you want to Logout?'),
  //             actions: <Widget>[
  //               FlatButton(
  //                 child: Text('Cancel'),
  //                 onPressed: () {
  //                   Navigator.of(dialogContext).pop(); // Dismiss alert dialog
  //                 },
  //               ),
  //               FlatButton(
  //                 child: Text('Logout'),
  //                 onPressed: () async{
  //                   SharedPreferences prefs = await SharedPreferences.getInstance();
  //                   prefs.remove('isLoggedIn');
  //                   Navigator.of(context).pushAndRemoveUntil(
  //                     // the new route
  //                     MaterialPageRoute(
  //                       builder: (BuildContext context) => SplashScreen(),
  //                     ),
  //
  //                         (Route route) => false,
  //                   );// Dismiss alert dialog
  //                 },
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //       break;
  //     case 'Settings':
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
  //       break;
  //   }
  // }

   logoutAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return LogoutAlert();
      },
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
