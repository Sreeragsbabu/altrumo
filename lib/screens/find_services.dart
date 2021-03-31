import 'package:demo_altrumo/appointment_models/specialities.dart';
import 'package:demo_altrumo/guest_screens/find_services_screen.dart';
import 'package:demo_altrumo/services/appointment_services.dart';
import 'package:flutter/material.dart';
import 'package:demo_altrumo/models/departments.dart';
import 'package:demo_altrumo/screens/dept_doctors_screen.dart';
import 'package:demo_altrumo/services/my_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FindServicesScreen extends StatefulWidget {

  @override
  _FindServicesScreenState createState() => _FindServicesScreenState();
}

class _FindServicesScreenState extends State<FindServicesScreen> {
  bool isCheck= false;
  List<Specialities> specialities;
  //List<Department> departments;
  bool _loading;
  String token = "";
  String pName = "";
  String uhid = "";

  @override
  void initState() {
    _loading = true;
    checkUser();
    loadSpecialities();
    /*DepartmentServices.getDepartments().then((dept) {
      setState(() {
        departments = dept;
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
  loadSpecialities() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString('token');
    var hospitalId = prefs.getInt('hospitalId').toString();
    token = tokenId;
    AppointmentServices.getSpecialities(token, hospitalId).then((hosp) {
      if(this.mounted){
        setState(() {
          specialities = hosp;
          print(specialities);
          _loading = false;
        });
      }
    });
  }
  //final List<Department> departments = Department.getDepartments();

  @override
  Widget build(BuildContext context) {
    return isCheck? GuestFindServicesScreen(): SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Specialities"),
        ),
        body: _loading? Center(child: CircularProgressIndicator()):ListView.builder(
          itemCount: specialities.length,
          itemBuilder: (context, index){
            return
            Card(
              child: ListTile(
                onTap: (){
                  print(specialities[index].id);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DepartmentDoctorsScreen(deptId: specialities[index].id,specialityName: specialities[index].value,)));
                },
                leading: CircleAvatar(
                  child: Text(specialities[index].value.substring(0,1)),
                ),
                title: Text(specialities[index].value),),
            );
          },
        ),
      ),
    );
  }
}
