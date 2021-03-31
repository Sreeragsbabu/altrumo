import 'package:demo_altrumo/appointment_models/doctors.dart';
import 'package:demo_altrumo/services/appointment_services.dart';
import 'package:flutter/material.dart';
import 'package:demo_altrumo/screens/main_drawer.dart';
import 'package:demo_altrumo/models/doctors.dart';
import 'package:demo_altrumo/screens/doctor_details_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:demo_altrumo/services/my_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDocTab extends StatefulWidget {
  @override
  _MyDocTabState createState() => _MyDocTabState();
}

class _MyDocTabState extends State<MyDocTab> {
  //List<Doctors> doctors = Doctors.getDoctors();
  //List<Doctors> doctors;
  List<SpecDoctors> doctors;
  bool _loading;

  @override
  void initState() {
    _loading = true;
    loadConsultants();
    /*AllDoctorServices.getDoctors().then((doctor) {
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
   /*bool isFavourite = true;
   bool isFavourite1 = true;
   bool isFavourite2 = true;*/
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            title: Text("My Doctors"),
          ),
          drawer: Drawer(
            child: MainDrawer(),
          ),
        body: _loading? Center(child: CircularProgressIndicator()):
        Container(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: (){
                      /*Navigator.push(context, MaterialPageRoute(builder: (context)=> DoctorDetailsScreen(
                        imageUrl: 'assets/doctor_img.jpg',likes: doctors[index].likes,
                        experience: doctors[index].experience,category: doctors[index].department,
                        name: doctors[index].name,
                      )));*/
                    },
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          //border: Border.all(color: Colors.black54),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/doctor_img.jpg'), fit: BoxFit.cover)),
                    ),
                    title: Text(doctors[index].employeeName),
                    subtitle: Text(
                        doctors[index].departmentName
                    ),
                    trailing: GestureDetector(
                      onTap: (){
                        Fluttertoast.showToast(msg: "removed from favourite list");
                      },
                        child: Icon(Icons.favorite, color: Colors.orange, )),
                    isThreeLine: true,

                  ),
                );
              },
            ),
          ),),
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
