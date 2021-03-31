import 'package:flutter/material.dart';

import 'package:demo_altrumo/models/patients.dart';
import 'package:demo_altrumo/screens/add_member_screen.dart';
import 'package:demo_altrumo/drawer_screens/edit_profile_screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo_altrumo/models/patients.dart';
import 'package:demo_altrumo/services/my_services.dart';
import 'package:demo_altrumo/models/doctors.dart';
import 'package:demo_altrumo/profile_models/patient_details.dart';
import 'package:demo_altrumo/services/login_services.dart';
import 'package:demo_altrumo/alert_dialogs/guest_login_alert.dart';

class MyProfileScreen extends StatefulWidget {

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {

  bool isCheck = false;
 // List<Doctors> getPatients;
  PatientDetails patientDetails;
  bool _loading;
  @override
  void initState() {
    checkUser();
    loadData();
    super.initState();
  }

 checkUser() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   var isGuest = prefs.getString('displayName');
   if(isGuest == "Guest"){
     setState(() {
       isCheck = true;
     });
   }

 }

  void loadData() async{
    _loading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString('token');
    var _uhid = prefs.getString('uhid');
    /*AllDoctorServices.getDoctors().then((upcoming) {
      setState(() {
        getPatients = upcoming;
        _loading = false;
      });

    });*/
    PatientDetailServices.getPatientDetails(tokenId, _uhid).then((value) {
      setState(() {
        patientDetails = value;
        _loading = false;
      });
    });

  }

 //List<Patients> getPatients = Patients.getPatients();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isCheck ? Scaffold(
        appBar: AppBar(
          title: Text("Info"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  children: [
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        GestureDetector(
                                onTap: (){
                          Navigator.pop(context);
                          },
                            child: Icon(Icons.arrow_back, color: Colors.black54,)),
                        Spacer(),
                        // Icon(Icons.notifications_none,color: Colors.black54,),
                        // SizedBox(width: 20.0,),
                        Icon(Icons.settings,color: Colors.black54,),

                      ],
                    ),*/
                    //SizedBox(height: 10.0,),
                    GestureDetector(
                      onTap: (){
                        showDialog<void>(
                          context: context,
                          barrierDismissible: true,
                          // false = user must tap button, true = tap outside dialog
                          builder: (BuildContext dialogContext) {
                            return GuestLoginAlert();
                          },
                        );
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
                      },
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage("assets/pro_pic.png"),
                            radius: 36.0,
                          ),
                          SizedBox(width: 20.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Guest",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w500),),
                              SizedBox(height: 6.0,),
                              Text("guest@gmail.com",style: TextStyle(color: Colors.black54),),
                              SizedBox(height: 6.0,),
                              Text("Phone no.",style: TextStyle(color: Colors.black54),),
                              /*LinearPercentIndicator(
                                width: 200.0,
                                percent: 0.0,
                                lineHeight: 12.0,
                                progressColor: Colors.blue,
                                leading: Icon(Icons.mood),
                                center: Text("0%", style: TextStyle(fontSize: 11.0),),
                              )*/
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Divider(color: Colors.grey,)
                  ],
                ),
              ),
              Container(
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Gender",style: TextStyle(color: Colors.black54),),
                            SizedBox(height: 4.0,),
                            Text("",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500),)
                          ],
                        ),
                        ),
                      ),
                      VerticalDivider(color: Colors.grey,),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Column(
                            children: [
                              Text("Age",style: TextStyle(color: Colors.black54)),
                              SizedBox(height: 4.0,),
                              Text("",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500))
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(color: Colors.grey,),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Status",style: TextStyle(color: Colors.black54)),
                              SizedBox(height: 4.0,),
                              Text("",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500))
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
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Blood Group",style: TextStyle(color: Colors.black54),),
                              SizedBox(height: 4.0,),
                              Text("",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500),)
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(color: Colors.grey,),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Column(
                            children: [
                              Text("Height",style: TextStyle(color: Colors.black54)),
                              SizedBox(height: 4.0,),
                              Text("",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500))
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(color: Colors.grey,),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Weight",style: TextStyle(color: Colors.black54)),
                              SizedBox(height: 4.0,),
                              Text("",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500))
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
              Text("Family Members",style: TextStyle(color: Colors.blue),),
              SizedBox(height: 10.0,),
              /*Container(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: getPatients.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
                      },
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                          CircleAvatar(
                          backgroundImage: AssetImage("assets/pro_pic.png"),
                          radius: 36.0,
                          ),
                            SizedBox(height: 4,),
                            Flexible(child: Text(getPatients[index].name))
                          ],
                        ),
                      ),
                    );

                  },
                ),
              )*/


            ],
          ),
        )):

        Scaffold(
          appBar: AppBar(
            title: Text("Patient Info"),
            actions: [
              IconButton(icon: Icon(Icons.edit_outlined),onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
              },),
            ],
          ),

          body: _loading ? Center(child: CircularProgressIndicator()): Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    children: [
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage("assets/pro_pic.png"),
                            radius: 36.0,
                          ),
                          SizedBox(width: 20.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(patientDetails.firstName + " "+ patientDetails.lastName,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w500),),
                              SizedBox(height: 6.0,),
                              Text(patientDetails.email,style: TextStyle(color: Colors.black54),),
                              SizedBox(height: 6.0,),
                              Text(patientDetails.mobileNo,style: TextStyle(color: Colors.black54),),
                              /*LinearPercentIndicator(
                                width: 200.0,
                                percent: 0.4,
                                lineHeight: 12.0,
                                progressColor: Colors.blue,
                                leading: Icon(Icons.mood),
                                center: Text("40%", style: TextStyle(fontSize: 11.0),),
                              )*/
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10.0,),
                      Divider(color: Colors.grey,)
                    ],
                  ),
                ),
                Container(
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Gender",style: TextStyle(color: Colors.black54),),
                                SizedBox(height: 4.0,),
                                Text(patientDetails.gender,style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500),)
                              ],
                            ),
                          ),
                        ),
                        VerticalDivider(color: Colors.grey,),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Column(
                              children: [
                                Text("Age",style: TextStyle(color: Colors.black54)),
                                SizedBox(height: 4.0,),
                                Text(patientDetails.age.substring(0,2),style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500))
                              ],
                            ),
                          ),
                        ),
                        VerticalDivider(color: Colors.grey,),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("Status",style: TextStyle(color: Colors.black54)),
                                SizedBox(height: 4.0,),
                                Text("Single",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500))
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
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Blood Group",style: TextStyle(color: Colors.black54),),
                                SizedBox(height: 4.0,),
                                Text("O+ve",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500),)
                              ],
                            ),
                          ),
                        ),
                        VerticalDivider(color: Colors.grey,),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Column(
                              children: [
                                Text("Height",style: TextStyle(color: Colors.black54)),
                                SizedBox(height: 4.0,),
                                Text("170 cm",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500))
                              ],
                            ),
                          ),
                        ),
                        VerticalDivider(color: Colors.grey,),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("Weight",style: TextStyle(color: Colors.black54)),
                                SizedBox(height: 4.0,),
                                Text("57 kgs",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500))
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Text("Family Members",style: TextStyle(color: Colors.blue),),
                SizedBox(height: 10.0,),
                /*Container(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: getPatients.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
                        },
                        child: Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage("assets/pro_pic.png"),
                                radius: 36.0,
                              ),
                              SizedBox(height: 4,),
                              Flexible(child: Text(getPatients[index].name))
                            ],
                          ),
                        ),
                      );

                    },
                  ),
                )*/


              ],
            ),
          ),
        )
    );
  }






}
