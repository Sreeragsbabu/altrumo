import 'package:demo_altrumo/appointment_models/past_appointments.dart';
import 'package:demo_altrumo/profile_models/patient_details.dart';
import 'package:demo_altrumo/services/appointment_services.dart';
import 'package:demo_altrumo/services/login_services.dart';
import 'package:flutter/material.dart';
import 'package:demo_altrumo/screens/doctor_appointment_screen2.dart';
import 'package:demo_altrumo/services/my_services.dart';
import 'package:demo_altrumo/models/past_appointments.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PastScreen extends StatefulWidget {
  @override
  _PastScreenState createState() => _PastScreenState();
}

class _PastScreenState extends State<PastScreen> {
 // List<Patients> patients = Patients.getPatients();
  List<PastAppointments> pastAppts;
  bool _loading;
  bool _load;
  PatientDetails patientDetails;

  @override
  void initState() {
    _loading = true;
    _load = true;
    loadToken();

  }
  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString('token');
    var _uhid = prefs.getString('uhid');
    AppointmentServices.getPastAppointments(tokenId, _uhid).then((appts) {
      setState(() {
        pastAppts = appts;
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
  /*List<Doctors> doctors = Doctors.getDoctors();*/
  @override
  Widget build(BuildContext context) {
    return _loading || _load ? Center(child: CircularProgressIndicator()):
    Container(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: pastAppts.length,
          itemBuilder: (context, index) {
            DateTime convertedDate = pastAppts[index].appointmentDate;
            String formattedDate = DateFormat('yyyy-MM-dd').format(convertedDate);
            return Container(
              //padding: EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius:24.0,
                            backgroundImage: AssetImage("assets/pro_pic.png"),
                          ),
                          SizedBox(width: 16.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(pastAppts[index].consultantName,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500),),
                              Text(pastAppts[index].departmentName,style: TextStyle(color: Colors.black54),)
                            ],
                          ),
                          // Spacer(),
                          // Icon(Icons.more_vert_sharp,color: Colors.black54,)
                        ],
                      ),
                      SizedBox(height: 10.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Patient Name",style: TextStyle(color: Colors.black54),),
                              Text(patientDetails.firstName,style: TextStyle(fontWeight: FontWeight.w500)),
                              //Text(patients[index].name,style: TextStyle(fontWeight: FontWeight.w500)),
                            ],
                          ),
                          FlatButton(
                            height: 30,
                            onPressed: (){
                              bookDoctorBottomSheet(pastAppts[index].consultantName, pastAppts[index].departmentName, "assets/pro_pic.png");
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentScreen()));
                            },
                            color: Colors.blue,
                            child: Text("Rebook",style: TextStyle(color: Colors.white),),
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Date",style: TextStyle(color: Colors.black54),),
                          Text("Time",style: TextStyle(color: Colors.black54),),
                        ],
                      ),
                      SizedBox(height: 4.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child: Text(formattedDate,style: TextStyle(fontWeight: FontWeight.w500))),
                          Text(pastAppts[index].startTime+" - " +pastAppts[index].endTime,style: TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),



                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),);
  }

  void bookDoctorBottomSheet(String docName,String docCategory,String docImageUrl) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xff737373),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
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
                      SizedBox(width: 20.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(docName,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                          SizedBox(height: 4.0,),
                          Text(docCategory,style: TextStyle(color: Colors.black54),)
                        ],
                      )
                    ],
                  ),
                  Divider(color: Colors.grey,),
                  Text("Select an option to book",),
                  ListTile(
                    onTap: () {
                      /*Navigator.push(context, MaterialPageRoute(builder: (context)=> MyDoctorAppointmentScreen(consultationType: "phone",
                        docName: docName,docCategory: docCategory,docImageUrl: docImageUrl,)));*/
                    },
                    leading: CircleAvatar(
                      radius: 16.0,
                      backgroundImage: AssetImage("assets/phone_doc.png"),
                    ),
                    title: Text("Phone Consultation"),
                    subtitle: Text("Min session 10 mins . ₹0.99 per/min"),
                  ),

                  ListTile(
                    onTap: (){
                     /* Navigator.push(context, MaterialPageRoute(builder: (context)=> MyDoctorAppointmentScreen(consultationType: "video",
                        docName: docName,docCategory: docCategory,docImageUrl: docImageUrl,)));*/
                    },
                    leading: CircleAvatar(
                      radius: 16.0,
                      backgroundImage: AssetImage("assets/video_doc.png"),
                    ),
                    title: Text("Video Consultation"),
                    subtitle: Text("Min session 15 mins . ₹1.99 per/min"),
                  ),

                  ListTile(
                    onTap: (){
                      /*Navigator.push(context, MaterialPageRoute(builder: (context)=> MyDoctorAppointmentScreen(consultationType: "physical",
                        docName: docName,docCategory: docCategory,docImageUrl: docImageUrl,)));*/
                    },
                    leading:  CircleAvatar(
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
