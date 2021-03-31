import 'package:demo_altrumo/appointment_models/specialities.dart';
import 'package:demo_altrumo/services/guest_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo_altrumo/guest_screens/department_doctors_screen.dart';

class GuestFindServicesScreen extends StatefulWidget {
  @override
  _GuestFindServicesScreenState createState() => _GuestFindServicesScreenState();
}

class _GuestFindServicesScreenState extends State<GuestFindServicesScreen> {
  bool guestLoading;
  List<Specialities> guestSpecialities;

  @override
  void initState() {
    guestLoading = true;
    loadSpecialities();
    // TODO: implement initState
    super.initState();
  }

  loadSpecialities() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var hospitalId = prefs.getInt('hospitalId').toString();
    GuestServices.getSpecialities(hospitalId).then((hosp) {
      if(this.mounted){
        setState(() {
          guestSpecialities = hosp;
          print(guestSpecialities);
          guestLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Specialities"),
        ),
        body: guestLoading? Center(child: CircularProgressIndicator()):ListView.builder(
          itemCount: guestSpecialities.length,
          itemBuilder: (context, index){
            return
              Card(
                child: ListTile(
                  onTap: (){
                    print(guestSpecialities[index].id);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GuestDepartmentDoctors(id: guestSpecialities[index].id,specialityName: guestSpecialities[index].value,)));
                  },
                  leading: CircleAvatar(
                    child: Text(guestSpecialities[index].value.substring(0,1)),
                  ),
                  title: Text(guestSpecialities[index].value),),
              );
          },
        ),
      ),
    );
  }


}
