import 'package:demo_altrumo/appointment_models/doctors.dart';
import 'package:demo_altrumo/appointment_screens/time_slot.dart';
import 'package:demo_altrumo/guest_screens/all_doctors_screen.dart';
import 'package:demo_altrumo/screens/login_screen.dart';
import 'package:demo_altrumo/services/appointment_services.dart';
import 'package:demo_altrumo/services/guest_services.dart';
import 'package:flutter/material.dart';
import 'package:demo_altrumo/screens/doctor_details_screen.dart';
import 'package:demo_altrumo/screens/doctor_appointment_screen2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'phone_auth_screen.dart';
import 'package:demo_altrumo/services/my_services.dart';
import 'package:demo_altrumo/screens/login_screen.dart';
import 'appointment_screen.dart';


class MyDoctorsListScreen extends StatefulWidget {
  @override
  _MyDoctorsListScreenState createState() => _MyDoctorsListScreenState();
}

class _MyDoctorsListScreenState extends State<MyDoctorsListScreen> {
  //List<Doctors> doctors;
  bool isCheck = false;
  List<SpecDoctors> consultants;
  bool _loading;
  String pName = "";
  String uhid = "";

  @override
  void initState() {
    _loading = true;
    checkUser();
    if(isCheck == false){
      loadName();
      loadConsultants();
    }


   /* AllDoctorServices.getDoctors().then((doctor) {
      setState(() {
        doctors = doctor;
        _loading = false;
      });

    });*/

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
  loadName()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var patientName = prefs.getString('displayName');
    var _uhid = prefs.getString('uhid');
    setState(() {
      pName = patientName;
      uhid = _uhid;
    });
  }
  loadConsultants() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString('token');
    var hospitalId = prefs.getInt('hospitalId').toString();

    /*depId = widget.deptId.toString();
    token = tokenId;*/
    print("111111" + tokenId);
    print(hospitalId);
    AppointmentServices.getAllConsultants(tokenId, hospitalId).then((doc) {
      if (this.mounted) {
        setState(() {
          consultants = doc;
          print(consultants);
          _loading = false;
        });
      }
    });
  }
  //final List<Doctors> doctors = Doctors.getDoctors();

  @override
  Widget build(BuildContext context) {
    return isCheck? GuestAllDoctors():
    SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("All Doctors"),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: (){
                  showSearch(context: context, delegate: DoctorSearch(consultants));
                },
                icon: Icon(Icons.search,color: Colors.white,),
              )
            ],
          ),
          body: _loading? Center(child: CircularProgressIndicator()):Container(
        child: consultants.isEmpty? Center(
            child: Text(
                "Currently no doctors available in this Hospital")): ListView.builder(
          itemCount: consultants.length,
          itemBuilder: (context, index){
            return  GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorDetailsScreen(
                  name: consultants[index].employeeName,
                category: consultants[index].departmentName,
                uhid: uhid,
                docId: consultants[index].id,
                docName: consultants[index].employeeName,
                patientName: pName,
                doctors: consultants,
                experience: 5,
                likes: 230,
                imageUrl: "assets/doctor_img.jpg",
                depId: consultants[index].departmentId,)
                ));
              },
              child: Card(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage: AssetImage("assets/doctor_img.jpg"),
                                ),

                                SizedBox(height: 8.0,),
                                Container(
                                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                                    width: 40,
                                    height: 18,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2.0),
                                        // border: Border.all(color: Colors.black54),
                                        shape: BoxShape.rectangle,
                                        color: Colors.orange),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.star,color: Colors.white,size: 12.0,),
                                        Flexible(child: Text(4.3.toString(),style: TextStyle(color: Colors.white, fontSize: 12.0),))
                                      ],
                                    )
                                )
                              ],
                            ),
                            SizedBox(width: 16.0,),
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(consultants[index].employeeName,style: TextStyle(fontSize: 18.0),),
                                  SizedBox(height: 4.0,),
                                  Text(consultants[index].departmentName,style: TextStyle(color: Colors.black54),),
                                  SizedBox(height: 4.0,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.location_on, color: Colors.black54,size: 14.0,),
                                      SizedBox(width: 4.0,),
                                      Text("Location",style: TextStyle(color: Colors.black54),)
                                    ],
                                  )

                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10.0,),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Experience",style: TextStyle(color: Colors.black54,fontSize: 16.0),),
                                    SizedBox(height: 4.0,),
                                    Text(5.toString()+" years")
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Column(
                                  children: [
                                    Text("Likes",style: TextStyle(color: Colors.black54,fontSize: 16.0),),
                                    SizedBox(height: 4.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(230.toString()),
                                        SizedBox(width: 4.0,),
                                        Icon(Icons.thumb_up,size: 14.0,color: Colors.black54,),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: FlatButton(
                                    height: 30,
                                    onPressed: () async{
                                      bookDoctorBottomSheet
                                        (consultants[index].employeeName,
                                          consultants[index].departmentName,
                                          consultants[index].id,
                                          consultants[index].departmentId,
                                          "assets/doctor_img.jpg");

                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentScreen()));
                                    },

                                    color: Colors.blue,
                                    child: Text("Book",style: TextStyle(color: Colors.white),),
                                  ),
                                )
                            )
                          ],
                        )
                      ],
                    ),
                  )
              ),
            );
          },
        ),
      )),
    );
  }

  void bookDoctorBottomSheet(String docName,String docCategory,int doctId,int deptId, String docImageUrl) {
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          TimeSlot(
                            pName: pName,
                            docId: doctId,
                            deptId: deptId,
                            speciality: docCategory,
                            conType: "Phone",
                            doctName: docName,
                            uhid: uhid,
                          )
                          /*MyDoctorAppointmentScreen(consultationType: "phone",
                        docName: docName,docCategory: docCategory,docImageUrl: docImageUrl,)*/
                      ));
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          TimeSlot(
                            pName: pName,
                            docId: doctId,
                            deptId: deptId,
                            speciality: docCategory,
                            conType: "Video",
                            doctName: docName,
                            uhid: uhid,
                          )
                          /*MyDoctorAppointmentScreen(consultationType: "video",
                        docName: docName,docCategory: docCategory,docImageUrl: docImageUrl,)*/
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          TimeSlot(
                            pName: pName,
                            docId: doctId,
                            deptId: deptId,
                            speciality: docCategory,
                            conType: "Physical Visit",
                            doctName: docName,
                            uhid: uhid,
                          )
                          /*MyDoctorAppointmentScreen(consultationType: "physical",
                        docName: docName,docCategory: docCategory,docImageUrl: docImageUrl,)*/
                      ));
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



class DoctorSearch extends SearchDelegate{


  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(
      icon: Icon(Icons.close),
      onPressed: (){
        query ="";
      },
    )];
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        Navigator.pop(context);
      },
    );
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  final List<SpecDoctors> listDoctors;
  DoctorSearch(this.listDoctors);
  @override
  Widget buildSuggestions(BuildContext context) {
    String pName ="";
    String uhid ='';

    loadName()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var patientName = prefs.getString('displayName');
      var _uhid = prefs.getString('uhid');
      pName = patientName;
      uhid = _uhid;

    }
    loadName();
    List<SpecDoctors> suggestionList = [];
    suggestionList.addAll(listDoctors.where((element)
    //=>element.name.contains(query)
    {
      var convertedList =element.departmentName.toLowerCase();
      var convertedListName =element.employeeName.toLowerCase();
      return convertedList.contains(query) || convertedListName.contains(query);
    }
    ));
    // TODO: implement buildSuggestions
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index){
        return GestureDetector(
          onTap: (){
            /*Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorDetailsScreen(
              name: consultants[index].employeeName,
              category: consultants[index].departmentName,
              uhid: uhid,
              docId: consultants[index].id,
              docName: consultants[index].employeeName,
              patientName: pName,
              doctors: consultants,
              experience: 5,
              likes: 230,
              imageUrl: "assets/doctor_img.jpg",)*/

            Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorDetailsScreen(
              name: suggestionList[index].employeeName,
              category: suggestionList[index].departmentName,
              uhid: uhid,
              patientName: pName,
              docName: suggestionList[index].employeeName,
              docId: suggestionList[index].id,
              doctors: suggestionList,
              experience: 5,
              likes: 230,
              imageUrl: "assets/doctor_img.jpg",depId: suggestionList[index].departmentId,)));
          },
          child: Card(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundImage: AssetImage('assets/doctor_img.jpg'),
                            ),

                            SizedBox(height: 8.0,),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 4.0),
                                width: 40,
                                height: 18,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.0),
                                    // border: Border.all(color: Colors.black54),
                                    shape: BoxShape.rectangle,
                                    color: Colors.orange),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.star,color: Colors.white,size: 12.0,),
                                    Flexible(child: Text(4.3.toString(),style: TextStyle(color: Colors.white, fontSize: 12.0),))
                                  ],
                                )
                            )
                          ],
                        ),
                        SizedBox(width: 16.0,),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(suggestionList[index].employeeName,style: TextStyle(fontSize: 18.0),),
                              SizedBox(height: 4.0,),
                              Text(suggestionList[index].departmentName,style: TextStyle(color: Colors.black54),),
                              SizedBox(height: 4.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on, color: Colors.black54,size: 14.0,),
                                  SizedBox(width: 4.0,),
                                  Text("Location",style: TextStyle(color: Colors.black54),)
                                ],
                              )

                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Experience",style: TextStyle(color: Colors.black54,fontSize: 16.0),),
                                SizedBox(height: 4.0,),
                                Text(5.toString()+" years")
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Column(
                              children: [
                                Text("Likes",style: TextStyle(color: Colors.black54,fontSize: 16.0),),
                                SizedBox(height: 4.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(230.toString()),
                                    SizedBox(width: 4.0,),
                                    Icon(Icons.thumb_up,size: 14.0,color: Colors.black54,),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: FlatButton(
                                height: 30,
                                onPressed: () async{
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  var dispName = prefs.getString('displayName');
                                  var isGuest = prefs.getString('displayName');
                                  print(isGuest);
                                  if(isGuest == "Guest"){
                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible:
                                      true,
                                      // false = user must tap button, true = tap outside dialog
                                      builder:
                                          (BuildContext dialogContext) {
                                        return AlertDialog(
                                          title: Text('Confirm Login!!!!'),
                                          content: Text('Login is required for further process'),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text('Login'),
                                              onPressed: () {
                                                Navigator.of(dialogContext)
                                                    .pop();
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));// Dismiss alert dialog
                                              },
                                            ),
                                            FlatButton(
                                              child: Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(dialogContext)
                                                    .pop(); // Dismiss alert dialog
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                              }
                                  else{
                                    bookDoctorBottomSheet(
                                        suggestionList[index].employeeName,
                                        suggestionList[index].departmentName,
                                        suggestionList[index].id,
                                        pName,uhid,
                                        suggestionList[index].departmentId,
                                        "assets/doctor_img.jpg", context);
                                  }

                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentScreen()));
                                },
                                color: Colors.blue,
                                child: Text("Book",style: TextStyle(color: Colors.white),),
                              ),
                            )
                        )
                      ],
                    )
                  ],
                ),
              )
          ),
        );
      },
    );
    throw UnimplementedError();
  }

  void bookDoctorBottomSheet(String docName,String docCategory,int doctId, String pName, String uhid,int deptId, String docImageUrl, BuildContext context) {
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          TimeSlot(
                            pName: pName,
                            docId: doctId,
                            deptId: deptId,
                            speciality: docCategory,
                            conType: "Phone",
                            doctName: docName,
                            uhid: uhid,
                          )
                          /*MyDoctorAppointmentScreen(consultationType: "phone",
                        docName: docName,docCategory: docCategory,docImageUrl: docImageUrl,)*/
                      ));
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          TimeSlot(
                            pName: pName,
                            docId: doctId,
                            deptId: deptId,
                            speciality: docCategory,
                            conType: "Video",
                            doctName: docName,
                            uhid: uhid,
                          )
                          /*MyDoctorAppointmentScreen(consultationType: "video",
                        docName: docName,docCategory: docCategory,docImageUrl: docImageUrl,)*/
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          TimeSlot(
                            pName: pName,
                            docId: doctId,
                            deptId: deptId,
                            speciality: docCategory,
                            conType: "Physical visit",
                            doctName: docName,
                            uhid: uhid,
                          )
                          /*MyDoctorAppointmentScreen(consultationType: "physical",
                        docName: docName,docCategory: docCategory,docImageUrl: docImageUrl,)*/
                      ));
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

