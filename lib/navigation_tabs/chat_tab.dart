import 'package:demo_altrumo/appointment_models/doctors.dart';
import 'package:demo_altrumo/models/doctors.dart';
import 'package:demo_altrumo/services/appointment_services.dart';
import 'package:flutter/material.dart';
import 'package:demo_altrumo/screens/chat_screen.dart';
import 'package:demo_altrumo/screens/main_drawer.dart';
import 'package:demo_altrumo/services/my_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatTab extends StatefulWidget {
  //List<Doctors> doctors = Doctors.getDoctors();


  @override
  _ChatTabState createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  //List<Doctors> doctors;
  List<SpecDoctors> doctors;
  bool _loading;

  @override
  void initState() {
    _loading = true;
    loadConsultants();
   /* AllDoctorServices.getDoctors().then((doctor) {
      setState(() {
        doctors = doctor;
        _loading = false;
      });

    });*/

  }
  loadConsultants() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString('token');
    var hospitalId = prefs.getInt('hospitalId').toString();
    /*depId = widget.deptId.toString();
    token = tokenId;*/
    print("111111" + tokenId);
    print(hospitalId);
    AppointmentServices.getAllConsultants(tokenId, '2').then((doc) {
      if (this.mounted) {
        setState(() {
          doctors = doc;
          print(doctors);
          _loading = false;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Messages"),
            actions: [
              IconButton(
                icon: Icon(Icons.search,color: Colors.white,),
              )
            ],
          ),
          drawer: Drawer(
            child: MainDrawer(),
          ),
          body: _loading? Center(child: CircularProgressIndicator()):
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 10.0),
            child: ListView.builder(
              itemCount: doctors.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(docName: doctors[index].employeeName,
                        docCategory:doctors[index].departmentName,docImageUrl: 'assets/doctor_img.jpg',)));
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage: AssetImage('assets/doctor_img.jpg'),
                                ),
                              ),
                              SizedBox(width: 20.0,),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(child: Text(doctors[index].employeeName,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w500),)),
                                          Flexible(child: Text("08:30 AM",style: TextStyle(color: Colors.black54),)),
                                        ],
                                      ),
                                      SizedBox(height: 8.0,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(child: Text("Ask a question to help online..",style: TextStyle(color: Colors.black54),)),
                                        ],
                                      ),
                                      SizedBox(height: 7.0,),
                                      Divider(color: Colors.grey,)
                                    ],
                                  ),
                                ),
                              )

                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
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



