import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'consultation_type.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SelectPatient extends StatefulWidget {
  @override
  _SelectPatientState createState() => _SelectPatientState();
}

class _SelectPatientState extends State<SelectPatient> {
  //bool _isSelect = true;
  String patientName ="";
  String patientUhid ="";

  @override
  void initState() {
    loadName();
  }
  loadName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dispName = prefs.getString('displayName');
    var pUhid = prefs.getString('uhid');
    if(pUhid == null){
      setState(() {
        patientName = dispName;
        patientUhid = "Uhid";
      });
    }
    else{
      setState(() {
        patientName = dispName;
        patientUhid = pUhid;
      });
    }


  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Select Patient"),
        ),
        //bottomNavigationBar: nextButton(),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                elevation: 10.0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ListTile(
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context) => ConsultationType(pName: patientName,uhid: patientUhid,)));
                      print(patientName+ patientUhid);
                        /*setState(() {
                          //_isSelect = !_isSelect;

                        });*/
                    },
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/pro_pic.png"),
                      radius: 36.0,
                    ),
                    /*trailing: _isSelect ?  CircleAvatar(
                      backgroundImage: AssetImage("assets/success.png"),
                      radius: 20.0,
                    ):CircleAvatar(
                      backgroundColor: Colors.white,
                    ),*/
                    title: Text(patientName),
                    subtitle: Text(patientUhid == null ? 'uhid':  patientUhid),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /*nextButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ConsultationType(pName: patientName,uhid: patientUhid,)));
       // print(_isSelect);
        *//*if(_isSelect == true){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ConsultationType(pName: displayName,uhid: patientUhid,)));
        }
        else{
          Fluttertoast.showToast(msg: "Select one patient");
        }*//*
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
}
