import 'package:flutter/material.dart';
import 'package:demo_altrumo/models/doctors.dart';
import 'package:demo_altrumo/services/my_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
class EhrSharedScreen extends StatefulWidget {
  //List<Doctors> doctors = Doctors.getDoctors();
  @override
  _EhrSharedScreenState createState() => _EhrSharedScreenState();
}

class _EhrSharedScreenState extends State<EhrSharedScreen> {
 // List<Doctors> doctors;
 // bool _loading;
  bool _isGuest = false;

  @override
  void initState() {
    //_loading = true;
    /*AllDoctorServices.getDoctors().then((doctor) {
      setState(() {
        doctors = doctor;
        _loading = false;
      });

    });*/
    checkUser();
  }
  checkUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isGuest = prefs.getString('displayName');
    if(isGuest == "Guest"){
      if(this.mounted){
        setState(() {
          _isGuest = true;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    /*if(_loading ==true){
      return Center(child: CircularProgressIndicator());
    }*/
    //else{
      return _isGuest?  Card(
        elevation: 20.0,
        child: ListTile(
          title: Text("Added by Dr. consulatant ", style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14.0),),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(6.0),
                color: Color(0xfff0f0f5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("01",style: TextStyle(fontWeight: FontWeight.w500)),
                    SizedBox(height: 4.0,),
                    Text("JAN",style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ),
              SizedBox(width: 10.0,),
              CircleAvatar(
                radius: 16.0,
                backgroundImage: AssetImage("assets/pro_pic.png"),
              )
            ],
          ),
          subtitle: Text("Record for Guest"),
          /*trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.more_vert_sharp)
              ],
            ),*/
        ),
      ):
        ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text("Added by Dr. Kamal De Silva", style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14.0),),
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.0),
                      color: Color(0xfff0f0f5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("24",style: TextStyle(fontWeight: FontWeight.w500)),
                          SizedBox(height: 4.0,),
                          Text("NOV",style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    CircleAvatar(
                      radius: 16.0,
                      backgroundImage: AssetImage('assets/doctor_img.jpg'),
                    )
                  ],
                ),
                subtitle: Text("Record for Patient"),
                /*trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.more_vert_sharp)
              ],
            ),*/
              ),
            );
          },
        );

  }
}
