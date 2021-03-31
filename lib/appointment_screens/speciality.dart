import 'package:demo_altrumo/appointment_models/specialities.dart';
import 'package:demo_altrumo/services/appointment_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'department_doctors.dart';

class DoctorSpeciality extends StatefulWidget {
  final String pName,uhid,conType;

  const DoctorSpeciality({Key key, this.pName, this.uhid, this.conType}) : super(key: key);
  @override
  _DoctorSpecialityState createState() => _DoctorSpecialityState();
}

class _DoctorSpecialityState extends State<DoctorSpeciality> {
  String speciality ="";
  int deptId;
  int selectedIndex = -1;
  String token = "";
  List<Specialities> specialities;
  bool _loading;
  @override
  void initState() {
    loadName();
    _loading = true;


  }
  loadName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString('token');
    var hospitalId = prefs.getInt('hospitalId').toString();
    token = tokenId;
    if(tokenId == 'tokenGuest'){
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        // false = user must tap button , true = tap outside dialog
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('Login'),
            content: Text('Login is required for showing available Specialities'),
            actions: <Widget>[
              FlatButton(
                child: Text('cancel'),
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                },
              ),
            ],
          );
        },
      );
    }
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Speciality"),
        ),
        //bottomNavigationBar: nextButton(),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text("Patient Name :", style: TextStyle(fontSize: 16.0),)),
                          Flexible(
                            child: Container(
                                padding: EdgeInsets.only(left: 16.0),
                                child:  Text(

                                  widget.pName,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                )
                            ),
                          )
                        ],
                      ),

                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text("UHID : ", style: TextStyle(fontSize: 16.0),)),
                          Flexible(
                            child: Container(
                                padding: EdgeInsets.only(left: 16.0),
                                child:  Text(

                                  widget.uhid,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                )
                            ),
                          )
                        ],
                      ),
                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text("Type :", style: TextStyle(fontSize: 16.0),)),
                          Flexible(
                            child: Container(
                                padding: EdgeInsets.only(left: 16.0),
                                child:  Text(

                                  widget.conType,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                )
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.0,),
              Align(alignment: Alignment.center,child: Text("Select the Speciality ",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold))),
              SizedBox(height: 16.0,),
              Expanded(
                child: Container(
                  child: _loading
                      ? Center(child: CircularProgressIndicator()):
                  RefreshIndicator(
                    onRefresh: (){
                      return refreshData();
                    },
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: specialities.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex=index;
                               speciality  = specialities[index].value;
                                deptId  = specialities[index].id;
                              print(specialities[index].value);
                            });
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DepartmentDoctors(
                              pName: widget.pName,
                              uhid: widget.uhid,
                              conType: widget.conType,
                              speciality: speciality,
                              deptId: deptId,)));
                          },
                          child: Card(
                            shape: (selectedIndex==index)
                                ? RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.blue,width: 4.0))
                                :  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            elevation: 10,
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(specialities[index].value.substring(0,1)),
                              ),
                              title: Text(specialities[index].value),
                            ),
                          ),

                        );

                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*nextButton() {
    return GestureDetector(
      onTap: () {
        if(selectedIndex == -1){
          Fluttertoast.showToast(msg: "Please select which Speciality you want.");
        }
        else{
          print(speciality);
          print(deptId);
          Navigator.push(context, MaterialPageRoute(builder: (context) => DepartmentDoctors(
            pName: widget.pName,
            uhid: widget.uhid,
            conType: widget.conType,
          speciality: speciality,
          deptId: deptId,)));
        }

      },
      child: Container(
        alignment: Alignment.center,
        height: 48,
        width: MediaQuery.of(context).size.width,
        color: Color(0xff1976d2),
        child: Text(
          "Next",
          style: TextStyle(color: Colors.white, fontSize: 14.0),
        ),
      ),
    );
  }*/

  Future<String> refreshData() async{
    initState();
    return 'success';
  }
}
