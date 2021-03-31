import 'package:demo_altrumo/services/common_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'package:demo_altrumo/models/hospitals.dart';

class HospiatlLocationScreen extends StatefulWidget {


  @override
  _HospiatlLocationScreenState createState() => _HospiatlLocationScreenState();
}

class _HospiatlLocationScreenState extends State<HospiatlLocationScreen> {


  String token = "";
  List<Hospitals> hospitals;
  bool _loading;
  @override
  void initState() {
    loadName();
    _loading = true;

  }
    loadName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString('token');
    token = tokenId;
    print(token + "aaaaa");
    HospitalLocationServices.getHospitals(token).then((hosp) {
      if(this.mounted){
        setState(() {
          hospitals = hosp;
          print(hospitals);
          _loading = false;
        });
      }
    });
  }
  /*List<Hospitals> hospitals = [
    Hospitals(name:"Altrumo Hospital", location: "J P Nagar"),
    Hospitals(name:"Altrumo Hospital", location: "M G Road"),
    Hospitals(name:"Altrumo Hospital", location: "WhiteField"),
    Hospitals(name:"Altrumo Hospital", location: "BrookeField"),
  ];*/

  String selectedHospitalName;
  String selectedHospitalLocation;
  int selectedHospitalId;
  Hospitals selectedHospital;

  setSelectedUser(Hospitals hospital) {
    setState(() {
      selectedHospital = hospital;
    });
  }

  List<Widget> createRadioListUsers() {
    List<Widget> widgets = [];
    for (Hospitals hospital in hospitals) {
      widgets.add(
        RadioListTile(
          value: hospital,
          groupValue: selectedHospital,
          title: Text(hospital.name),
         // subtitle: Text(hospital.code),
          onChanged: (currentHospital) {
            selectedHospitalName = currentHospital.name;//hospitalname
            selectedHospitalLocation = currentHospital.code;
            selectedHospitalId = currentHospital.id;//hospitalId
            print(selectedHospitalId);
            setSelectedUser(currentHospital);
          },
          selected:selectedHospital == hospital,
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Location"),
        ),
        bottomNavigationBar: nextButton(),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    logo(),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Please choose your preferred",
                      style: TextStyle(color: Colors.black54, fontSize: 14.0),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Hospital location",
                      style: TextStyle(color: Colors.black54, fontSize: 14.0),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                  ],
                ),
                _loading
                    ? Center(child: CircularProgressIndicator())
                    : Column(children: createRadioListUsers()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  nextButton() {
    return GestureDetector(
      onTap: () async {
        try {
          if (selectedHospitalName.isNotEmpty) {
            //addData(nameController.text.toString());
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('hospitalName', selectedHospitalName.toString());
            prefs.setInt('hospitalId', selectedHospitalId);
            prefs.setString('hospitalLocation', selectedHospitalLocation.toString());
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen(
                          currentIndex: 0,
                        )),
                (Route<dynamic> route) => false);
          } else {
            Fluttertoast.showToast(msg: "please select one hospital");
          }
        } catch (exception) {
          Fluttertoast.showToast(msg: "please select one hospital");
          print(exception);
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 48,
        width: MediaQuery.of(context).size.width,
        color: Color(0xff1976d2),
        child: Text(
          "Continue",
          style: TextStyle(color: Colors.white, fontSize: 14.0),
        ),
      ),
    );
  }
/*  nextButton(context) {
    return GestureDetector(
      onTap: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen()),
                (Route<dynamic> route) => false);
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

  Widget logo() {
    return Container(
        width: 88,
        height: 88,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
                image: AssetImage("assets/altrumo.png"),
                fit: BoxFit.fitHeight)));
  }
}
