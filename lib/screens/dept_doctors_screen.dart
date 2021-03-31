import 'package:demo_altrumo/appointment_models/doctors.dart';
import 'package:demo_altrumo/appointment_screens/time_slot.dart';
import 'package:demo_altrumo/models/DeptDoctors.dart';
import 'package:demo_altrumo/models/departments.dart';
import 'package:demo_altrumo/services/appointment_services.dart';
import 'package:flutter/material.dart';
import 'appointment_screen.dart';
import 'doctor_appointment_screen2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'phone_auth_screen.dart';
import 'package:demo_altrumo/services/my_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:demo_altrumo/screens/login_screen.dart';

class DepartmentDoctorsScreen extends StatefulWidget {
  final int deptId;
  final String specialityName;

  const DepartmentDoctorsScreen({Key key, this.deptId, this.specialityName})
      : super(key: key);

  @override
  _DepartmentDoctorsScreenState createState() =>
      _DepartmentDoctorsScreenState();
}

class _DepartmentDoctorsScreenState extends State<DepartmentDoctorsScreen> {
  //List<DeptDoctors> departments;
  bool _loading;
  List<SpecDoctors> specialityDoctors;
  String pName = "";
  String uhid = "";

  @override
  void initState() {
    _loading = true;
    loadDoctors();
    loadName();
  }
  loadName()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var patientName = prefs.getString('displayName');
    var _uhid = prefs.getString('uhid');
    setState(() {
      pName = patientName;
      uhid = _uhid;
    });
  }
  loadDoctors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString('token');
    print("111111" + tokenId);
    AppointmentServices.getDoctors(tokenId, widget.deptId.toString()).then((doc) {
      if (this.mounted) {
        setState(() {
          specialityDoctors = doc;
          print(specialityDoctors);
          _loading = false;
        });
      }
    });
  }

 /* void loadDoctors() async {
    loadData(widget.deptId).then((value) => setState(() {
          departments = value;
          _loading = false;
        }));
  }*/


  /*Future<List<DeptDoctors>> loadData(int id) async {
    Map data = {
      'deptId': id,
    };

    String body = json.encode(data);

    http.Response response = await http.post(
      'http://10.10.10.92:8080/getdepartmentemployee',
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return deptDoctorsFromJson(responseString);
    } else {
      return null;
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.specialityName),
          ),
          body: _loading
              ? Center(child: CircularProgressIndicator())
              : Container(
                  child: specialityDoctors.isEmpty
                      ? Center(
                          child: Text(
                              "Currently no doctors available in this speciality"))
                      : ListView.builder(
                          itemCount: specialityDoctors.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Card(
                                  child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 30.0,
                                              backgroundImage: AssetImage(
                                                  "assets/doctor_img.jpg"),
                                            ),
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                                width: 40,
                                                height: 18,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.0),
                                                    // border: Border.all(color: Colors.black54),
                                                    shape: BoxShape.rectangle,
                                                    color: Colors.orange),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.white,
                                                      size: 12.0,
                                                    ),
                                                    Flexible(
                                                        child: Text(
                                                      "4.5",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12.0),
                                                    ))
                                                  ],
                                                ))
                                          ],
                                        ),
                                        SizedBox(
                                          width: 16.0,
                                        ),
                                        Flexible(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                    specialityDoctors[index]
                                                        .employeeName,
                                                style: TextStyle(fontSize: 18.0),
                                              ),
                                              SizedBox(
                                                height: 4.0,
                                              ),
                                              Text(
                                                specialityDoctors[index].departmentName,
                                                style: TextStyle(
                                                    color: Colors.black54),
                                              ),
                                              SizedBox(
                                                height: 4.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.black54,
                                                    size: 14.0,
                                                  ),
                                                  SizedBox(
                                                    width: 4.0,
                                                  ),
                                                  Text(
                                                    "Location",
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Experience",
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 16.0),
                                                ),
                                                SizedBox(
                                                  height: 4.0,
                                                ),
                                                Text("4 years")
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Likes",
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 16.0),
                                                ),
                                                SizedBox(
                                                  height: 4.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("125"),
                                                    SizedBox(
                                                      width: 4.0,
                                                    ),
                                                    Icon(
                                                      Icons.thumb_up,
                                                      size: 14.0,
                                                      color: Colors.black54,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                              child: FlatButton(
                                                height: 30,
                                                onPressed: () async {
                                                  SharedPreferences prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  var isGuest = prefs
                                                      .getString('displayName');
                                                  if (isGuest == "Guest") {
                                                    showDialog<void>(
                                                      context: context,
                                                      barrierDismissible: true,
                                                      // false = user must tap button, true = tap outside dialog
                                                      builder: (BuildContext
                                                          dialogContext) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              'Confirm Login!!!!'),
                                                          content: Text(
                                                              'Login is required for further process'),
                                                          actions: <Widget>[
                                                            FlatButton(
                                                              child:
                                                                  Text('Login'),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        dialogContext)
                                                                    .pop();
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                LoginScreen())); // Dismiss alert dialog
                                                              },
                                                            ),
                                                            FlatButton(
                                                              child: Text(
                                                                  'Cancel'),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        dialogContext)
                                                                    .pop(); // Dismiss alert dialog
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    bookDoctorBottomSheet(
                                                        specialityDoctors[index].employeeName,
                                                        specialityDoctors[index].departmentName,
                                                        specialityDoctors[index].id,
                                                        "assets/pro_pic.png",
                                                        context);
                                                    //Navigator.push(context, MaterialPageRoute(builder: (context) => MyDoctorAppointmentScreen()));
                                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentScreen()));
                                                  }
                                                },
                                                color: Colors.blue,
                                                child: Text(
                                                  "book",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              )),
                            );
                          },
                        ),
                )
          // body: ListView.builder(
          //   itemCount: departments.length,
          //   itemBuilder: (context, index){
          //     return ListTile(
          //       title: Text(departments[index]),
          //     );
          //   },
          // ),
          ),
    );
  }

  void bookDoctorBottomSheet(
      String docName, String docCategory,int doctId, String docImageUrl, context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xff737373),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: AssetImage(docImageUrl),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            docName,
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            docCategory,
                            style: TextStyle(color: Colors.black54),
                          )
                        ],
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Text(
                    "Select an option to book",
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TimeSlot(
                                    pName: pName,
                                    docId: doctId,
                                    deptId: widget.deptId,
                                speciality: docCategory,
                                conType: "phone",
                                doctName: docName,
                                uhid: uhid,
                                  )));
                    },
                    leading: CircleAvatar(
                      radius: 16.0,
                      backgroundImage: AssetImage("assets/phone_doc.png"),
                    ),
                    title: Text("Phone Consultation"),
                    subtitle: Text("Min session 10 mins . ₹0.99 per/min"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TimeSlot(
                                    pName: pName,
                                    docId: doctId,
                                    deptId: widget.deptId,
                                    speciality: docCategory,
                                    conType: "Video",
                                    doctName: docName,
                                    uhid: uhid,
                                  )
                                  /*MyDoctorAppointmentScreen(
                                    consultationType: "video",
                                    docName: docName,
                                    docCategory: docCategory,
                                    docImageUrl: docImageUrl,
                                  )*/
                          ));
                    },
                    leading: CircleAvatar(
                      radius: 16.0,
                      backgroundImage: AssetImage("assets/video_doc.png"),
                    ),
                    title: Text("Video Consultation"),
                    subtitle: Text("Min session 15 mins . ₹1.99 per/min"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TimeSlot(
                                    pName: pName,
                                    docId: doctId,
                                    deptId: widget.deptId,
                                    speciality: docCategory,
                                    conType: "Physical Visit",
                                    doctName: docName,
                                    uhid: uhid,
                                  )
                                  /*MyDoctorAppointmentScreen(
                                    consultationType: "physical",
                                    docName: docName,
                                    docCategory: docCategory,
                                    docImageUrl: docImageUrl,)*/
                          ));
                    },
                    leading: CircleAvatar(
                      radius: 16.0,
                      backgroundImage: AssetImage("assets/book_doc.png"),
                    ),
                    title: Text("Physical Visit"),
                    subtitle: Text("Book free, all fees are payable at clinic"),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
            ),
          );
        });
  }
}
