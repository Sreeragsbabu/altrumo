import 'package:demo_altrumo/alert_dialogs/guest_login_alert.dart';
import 'package:demo_altrumo/appointment_models/doctors.dart';
import 'package:demo_altrumo/appointment_screens/time_slot.dart';
import 'package:demo_altrumo/models/doctors.dart';
import 'package:flutter/material.dart';
import 'package:demo_altrumo/screens/chat_screen.dart';
import 'package:demo_altrumo/screens/doctor_appointment_screen2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo_altrumo/screens/login_screen.dart';
import 'phone_auth_screen.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final List<SpecDoctors> doctors;
  final String patientName;
  final String uhid;
  final String docName;
  final int docId;
  final String name;
  final String category;
  final int experience;
  final int likes;
  final String imageUrl;
  final int depId;

  const DoctorDetailsScreen({Key key, this.name, this.category, this.experience, this.likes, this.imageUrl, this.patientName, this.uhid, this.docName, this.docId, this.doctors, this.depId}) : super(key: key);

  @override
  _DoctorDetailsScreenState createState() => _DoctorDetailsScreenState();
}



class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {



  @override
  Widget build(BuildContext context) {
    int reviews = 230;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back)),
                        Spacer(),
                        GestureDetector(
                            child: Icon(Icons.favorite,color: Colors.orange,)),
                        //SizedBox(width: 10.0,),
                        IconButton(
                          onPressed: (){
                            _doctorBottomSheet(context);
                          },
                          icon: Icon(Icons.more_vert_sharp),)
                      ],
                    ),
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: AssetImage(widget.imageUrl),
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  Text(widget.name, style: TextStyle(fontSize: 22.0),),
                  SizedBox(height: 2.0,),
                  Text(widget.category,style: TextStyle(color: Colors.black54), ),
                  SizedBox(height: 16.0,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatScreen(docName: widget.name,docCategory: widget.category,docImageUrl: widget.imageUrl,)));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 20.0,
                                    backgroundImage: AssetImage("assets/chat_doc.png"),
                                  ),
                                  SizedBox(height: 4,),
                                  Text("Chat")
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              var isGuest = prefs.getString('displayName');
                              if(isGuest == "Guest"){
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
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                    TimeSlot(
                                      pName: widget.patientName,
                                      docId: widget.docId,
                                      deptId: widget.depId,
                                      speciality: widget.category,
                                      conType: "Phone",
                                      doctName: widget.docName,
                                      uhid: widget.uhid,
                                    )
                                    /*MyDoctorAppointmentScreen(consultationType: "phone",
                                  docName: widget.name,docCategory: widget.category,docImageUrl: widget.imageUrl,)*/
                                ));
                              }

                            },
                            child: Container(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 20.0,
                                    backgroundImage: AssetImage("assets/phone_doc.png"),
                                  ),
                                  SizedBox(height: 4,),
                                  Text("₹0.99/min")
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              var isGuest = prefs.getString('displayName');
                              if(isGuest == "Guest"){
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
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                    TimeSlot(
                                      pName: widget.patientName,
                                      docId: widget.docId,
                                      deptId: widget.depId,
                                      speciality: widget.category,
                                      conType: "Video",
                                      doctName: widget.docName,
                                      uhid: widget.uhid,
                                    )
                                   /* MyDoctorAppointmentScreen(consultationType: "video",
                                  docName: widget.name,docCategory: widget.category,docImageUrl: widget.imageUrl,)*/
                                ));
                              }

                            },
                            child: Container(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 20.0,
                                    backgroundImage: AssetImage("assets/video_doc.png"),
                                  ),
                                  SizedBox(height: 4,),
                                  Text("₹1.5/min")
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              var isGuest = prefs.getString('displayName');
                              if(isGuest == "Guest"){
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
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                    TimeSlot(
                                      pName: widget.patientName,
                                      docId: widget.docId,
                                      deptId: widget.depId,
                                      speciality: widget.category,
                                      conType: "Physical visit",
                                      doctName: widget.docName,
                                      uhid: widget.uhid,
                                    )
                                    /*MyDoctorAppointmentScreen(consultationType: "physical",
                                  docName: widget.name,docCategory: widget.category,docImageUrl: widget.imageUrl,)*/
                                ));
                              }

                            },
                            child: Container(
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 20.0,
                                    backgroundImage: AssetImage("assets/book_doc.png"),
                                  ),
                                  SizedBox(height: 4,),
                                  Text("Book")
                                ],
                              ),
                            ),
                          ),

                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Divider(color: Colors.grey,),
                  Container(
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Column(
                                children: [
                                  Text("Experience",style: TextStyle(color: Colors.grey),),
                                  SizedBox(height: 4.0,),
                                  Text(widget.experience.toString()+"+ years",style: TextStyle(fontSize: 16.0),),
                                ],
                              ),
                            ),
                          ),
                          VerticalDivider(color: Colors.orange,),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Column(
                                children: [
                                  Text("Likes",style: TextStyle(color: Colors.grey),),
                                  SizedBox(height: 4.0,),
                                  Text(widget.likes.toString(),style: TextStyle(fontSize: 16.0),),
                                ],
                              ),
                            ),
                          ),
                          VerticalDivider(color: Colors.black54,),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Column(
                                children: [
                                  Text("Reviews",style: TextStyle(color: Colors.grey),),
                                  SizedBox(height: 4.0,),
                                  Text(reviews.toString(),style: TextStyle(fontSize: 16.0),),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                           Icon(Icons.calendar_today_sharp,color: Colors.black54,),
                            SizedBox(width: 16.0,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Open Today",style: TextStyle(fontSize:16.0)),
                                SizedBox(height: 4.0,),
                                Text("10:30 AM - 07:30 PM",style: TextStyle(color: Colors.blue),),
                              ],
                            ),
                           Spacer(),
                            Text("All Timing",style: TextStyle(color: Colors.blue))
                          ],
                        ),
                          SizedBox(height: 10.0,),
                          Text.rich(TextSpan(
                          children: <TextSpan> [
                          TextSpan(text: widget.name+ " is a "+ widget.category+ " in Bengaluru and has an expeience of "+
                          widget.experience.toString()+"+ years in this field. We provide services in hospitals online consultation as "
                              "video and audio",style: TextStyle(color: Colors.black54)),
                          TextSpan(text: " More...",style: TextStyle(color: Colors.blue))
                          ]
                          ))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _doctorBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xff737373),
            child: Container(
              child: bottomNavigationDoctor(),
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
            ),
          );
        });
  }

  bottomNavigationDoctor() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: () {},
          leading: Icon(Icons.person_rounded),
          title: Text("Personal Information"),
        ),
        ListTile(
          leading: Icon(Icons.person_add_alt_1_sharp),
          title: Text("Working Address"),
        ),
        ListTile(
          leading: Icon(Icons.rate_review_sharp),
          title: Text("Reviewer"),
        ),
      ],
    );
  }


}
