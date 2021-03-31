import 'package:demo_altrumo/appointment_models/upcoming_appointmets.dart';
import 'package:demo_altrumo/profile_models/patient_details.dart';
import 'package:demo_altrumo/services/appointment_services.dart';
import 'package:demo_altrumo/services/login_services.dart';
import 'package:flutter/material.dart';
import 'package:demo_altrumo/models/upcoming_appointments.dart';
import 'package:demo_altrumo/models/patients.dart';
import 'package:demo_altrumo/screens/appointment_details_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:demo_altrumo/screens/doctor_appointment_screen2.dart';
import 'package:expandable/expandable.dart';
import 'package:demo_altrumo/services/my_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class UpcomingScreen extends StatefulWidget {
  @override
  _UpcomingScreenState createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  //bool _isVisible = false;
  //List<Doctors> doctors = Doctors.getDoctors();
  List<UpcomingAppointments> upcomingAppointments;
  PatientDetails patientDetails;
  bool _loading;
  bool _load;
  String hospitalName='';

  @override
  void initState() {
    _loading = true;
    _load = true;
    loadToken();
    loadHospName();

  }
  loadHospName()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var hospName = prefs.getString('hospitalName');
    setState(() {
      hospitalName = hospName;
    });
  }
  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString('token');
    var _uhid = prefs.getString('uhid');

    AppointmentServices.getUpcomingAppointments(tokenId,_uhid).then((upcoming) {
      setState(() {
        upcomingAppointments = upcoming;
        _loading = false;
      });
    });
    PatientDetailServices.getPatientDetails(tokenId, _uhid).then((value) {
      setState(() {
        patientDetails = value;
        _load = false;
      });
    });
  }
  //List<Patients> patients = Patients.getPatients();

  @override
  Widget build(BuildContext context) {

    return _loading || _load ? Center(child: CircularProgressIndicator(
      backgroundColor: Colors.green,
      strokeWidth: 5.0,
    )):
    ListView.builder(

      itemCount: upcomingAppointments.length,
      itemBuilder: (context, index) {
        DateTime convertedDate = upcomingAppointments[index].appointmentDate;
        String formattedDate = DateFormat('yyyy-MM-dd').format(convertedDate);
        return Container(
          padding: EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius:24.0,
                        backgroundImage: AssetImage("assets/pro_pic.png"),
                      ),
                      SizedBox(width: 16.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(upcomingAppointments[index].consultantName,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500),),
                          Text(upcomingAppointments[index].departmentName,style: TextStyle(color: Colors.black54),)
                        ],
                      ),
                      // Spacer(),
                      // GestureDetector(
                      //     child: Icon(Icons.visibility)),
                    ],
                  ),
                  SizedBox(height: 8.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 1,child: Text("Patient Name :",style: TextStyle(color: Colors.black54),)),
                      //Expanded(flex: 1,child: Text(patients[index].name,style: TextStyle(fontWeight: FontWeight.w500,color: Colors.blue,fontSize: 16.0))),
                      Expanded(flex: 1,child: Text(patientDetails.firstName,style: TextStyle(fontWeight: FontWeight.w500,color: Colors.blue,fontSize: 16.0))),
                    ],
                  ),
                  Divider(color: Colors.grey,),
                  //SizedBox(height: 8.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 1,child: Text("Date :",style: TextStyle(color: Colors.black54),)),
                      Expanded(flex: 1,child: Text(formattedDate,style: TextStyle(fontWeight: FontWeight.w500,color: Colors.blue,fontSize: 16.0))),

                    ],
                  ),
                  Divider(color: Colors.grey,),
                  //SizedBox(height: 8.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 1,child: Text("Consultation Time :",style: TextStyle(color: Colors.black54))),
                      Expanded(flex: 1,child: Text(upcomingAppointments[index].startTime+" - " +upcomingAppointments[index].endTime ,style: TextStyle(fontWeight: FontWeight.w500,color: Colors.blue,fontSize: 16.0)))
                    ],
                  ),
                  Divider(color: Colors.grey,),
                  // SizedBox(height: 8.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded (flex: 1,
                        child: Row(
                          children: [
                            Text("Hospital",style: TextStyle(color: Colors.black54)),
                            Icon(Icons.directions,color: Colors.orange,size: 18.0,),
                            Text(" :",style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ),
                      Expanded(flex: 1,child: Text(hospitalName,style: TextStyle(fontWeight: FontWeight.w500,color: Colors.blue,fontSize: 16.0)))
                    ],
                  ),
                  Divider(color: Colors.grey,),

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded (flex: 1,
                              child: Text("Consultation Type :",style: TextStyle(color: Colors.black54)),
                            ),
                            Expanded(flex: 1,child: Text("Type",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.blue,fontSize: 16.0)))
                          ],
                        ),
                        Divider(color: Colors.grey,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded (flex: 1,
                              child: Text("Appointment ID :",style: TextStyle(color: Colors.black54)),
                            ),
                            Expanded(flex: 1,child: Text(upcomingAppointments[index].referenceNo,style: TextStyle(fontWeight: FontWeight.w500,color: Colors.blue,fontSize: 16.0)))
                          ],
                        ),
                        Divider(color: Colors.grey,),
                        SizedBox(height: 10.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: (){
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: true,
                                    // false = user must tap button, true = tap outside dialog
                                    builder: (BuildContext dialogContext) {
                                      return AlertDialog(
                                        title: Text('Confirm!'),
                                        content: Text('Are you sure you want to reschedule the appointment?'),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('no'),
                                            onPressed: () {
                                              Navigator.of(dialogContext)
                                                  .pop(); // Dismiss alert dialog
                                            },
                                          ),
                                          FlatButton(
                                            child: Text('yes'),
                                            onPressed: () {
                                              Navigator.of(dialogContext)
                                                  .pop();
                                              Fluttertoast.showToast(msg: "cancelled");
                                             /* Navigator.push(context, MaterialPageRoute(builder: (context) => MyDoctorAppointmentScreen(
                                                docImageUrl: "assets/pro_pic.png",
                                                docCategory: upcomingAppointments[index].departmentName,
                                                docName: upcomingAppointments[index].consultantName,
                                                //docHospital: "Appolo Hospital",
                                                consultationType: "Audio Consultation",
                                              )));*/
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              //child: Icon(Icons.calendar_today_rounded,color: Colors.blue,),
                                child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 6.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.0),
                                      color: Color(0xffff9800),
                                    ),
                                    child: Text("Reschedule",style: TextStyle(color: Colors.white),))
                            ),
                            SizedBox(width: 20.0,),
                            GestureDetector(
                                onTap: (){
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: true,
                                    // false = user must tap button, true = tap outside dialog
                                    builder: (BuildContext dialogContext) {
                                      return AlertDialog(
                                        title: Text('Confirm!'),
                                        content: Text('Are you sure you want to cancel the appointment?'),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('no'),
                                            onPressed: () {
                                              Navigator.of(dialogContext)
                                                  .pop(); // Dismiss alert dialog
                                            },
                                          ),
                                          FlatButton(
                                            child: Text('yes'),
                                            onPressed: () {
                                              Navigator.of(dialogContext)
                                                  .pop();
                                              Fluttertoast.showToast(msg: "cancelled");
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              // child: Icon(Icons.cancel,color: Colors.red,),
                                child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 6.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.0),
                                      color: Colors.red,
                                    ),
                                    child: Text("Cancel",style: TextStyle(color: Colors.white),))
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bottomNavigationUpcomingAppointment(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentDetailsScreen()));
          },
          leading: Icon(Icons.camera_alt),
          title: Text("Details"),
        ),
        ListTile(
          leading: Icon(Icons.image),
          title: Text("Cancel Appointment"),
        ),
        ListTile(
          leading: Icon(Icons.delete),
          title: Text("Reschedule Appointment"),
        ),
      ],
    );
  }


}
