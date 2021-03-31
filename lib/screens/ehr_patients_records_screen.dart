import 'package:demo_altrumo/profile_models/vitals.dart';
import 'package:demo_altrumo/services/login_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EhrPatientsRecordsScreen extends StatefulWidget {
  @override
  _EhrPatientsRecordsScreenState createState() => _EhrPatientsRecordsScreenState();
}

class _EhrPatientsRecordsScreenState extends State<EhrPatientsRecordsScreen> {

  bool isCheck = false;
  int temp = 37;
  int pulse = 0;
  int weight = 0;
  int height = 0;
  double heightInch = 0.0;
  double bmi = 0.0;
  double heightMeter;
  String bloodGroup ="";
  int bloodPressure = 0;
  List<Vitals> vitals;
  bool _loading;


  @override
  void initState() {
    _loading = true;
    checkUser();
    loadData();
    super.initState();
  }
  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString('token');
    var _uhid = prefs.getString('uhid');
    PatientDetailServices.getPatientVitals(tokenId,_uhid).then((vitalsValue) {
      setState(() {
        vitals = vitalsValue;
        _loading = false;
      });

    });
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

  @override
  Widget build(BuildContext context) {
    return _loading ? Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.green,
      ),
    ): Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 10.0),
      child: GridView.builder(
        itemCount: vitals.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(10.0),),
              elevation: 10,
              child: Container(
                padding:
                EdgeInsets.symmetric(vertical: 5.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Text(
                            vitals[index].parameterName,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),)),
                    SizedBox(height: 8.0,),
                    /*CircleAvatar(backgroundImage: AssetImage('assets/whr.png'),
                    backgroundColor: Colors.white,),
                    SizedBox(height: 8.0,),*/
                    Flexible(
                        child: Text(
                            vitals[index].parameterValue +" "+ vitals[index].unit,style: TextStyle(color: Colors.blue),)),
                  ],
                ),
              ),
            );
          }),
    );
  }
  choiceChipBloodGroup({String chipLabel}) {
    return ChoiceChip(
      label: Text(chipLabel),
      labelStyle: TextStyle(color: Colors.white),
      backgroundColor: Colors.blue,
      selected: false,
      selectedColor: Colors.orange,
      onSelected: (value) {
        Navigator.pop(context);
        setState(() {
          bloodGroup = chipLabel + "ve";
        });
      },
    );
  }
}


/*
return Container(
//padding: EdgeInsets.all(10.0),
child: ListView(
children: [
StaggeredGridView.count(
crossAxisCount: 2,
scrollDirection: Axis.vertical,
shrinkWrap: true,
crossAxisSpacing: 12.0,
mainAxisSpacing: 12.0,
padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
children: [
InkWell(
onTap: () {

},
child: Container(
child: Material(
color: Colors.white,
elevation: 14.0,
shadowColor: Color(0x802196f3),
borderRadius: BorderRadius.circular(12.0),
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Flexible(
child: Text(isCheck? "Guest":
"Sreeragaaa", style: TextStyle(fontSize: 18.0),
)),
SizedBox(
height: 5,
),
Flexible(
child: Text(isCheck? "Gender | age":
"Male | 25",
)),
],
),
),
)),
),

InkWell(
onTap: () {
showDialog(
context: context,
builder: (context) {
return NumberPickerDialog.integer(
minValue: 1,
maxValue: 100,
initialIntegerValue: 37,
title: Text("Select your Temperature"),
);
}).then((value) {
if (value != null) {
setState(() {
temp = value;
});
}
});
},
child: Container(
child: Material(
color: Colors.white,
elevation: 14.0,
shadowColor: Color(0x802196f3),
borderRadius: BorderRadius.circular(12.0),
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
children: [
Flexible(
child: Text(
"Temperature",style: TextStyle(fontSize: 14.0),
)),
SizedBox(
height: 5,
),
Flexible(
child: Text(
temp.toString()+" °C",textAlign: TextAlign.end,  style: TextStyle(color: Color(0xff1976d2), fontSize: 16.0),
)),
],
),
),
))),
InkWell(
onTap: (){
showDialog(
context: context,
builder: (context) {
return NumberPickerDialog.integer(
minValue: 1,
maxValue: 150,
initialIntegerValue: 50,
title: Text("Select your weight"),
);
}).then((value) {
if (value != null) {
setState(() {
weight = value;
});
}
});
},
child: Container(
child: Material(
color: Colors.white,
elevation: 14.0,
shadowColor: Color(0x802196f3),
borderRadius: BorderRadius.circular(12.0),
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
children: [
Flexible(
child: Text(
"Weight",style: TextStyle(fontSize: 14.0),
)),
SizedBox(
height: 5,
),
Flexible(
child: Text(
weight.toString(),textAlign: TextAlign.end,  style: TextStyle(color: Color(0xff1976d2), fontSize: 16.0),
)),
],
)
),
))),
InkWell(
onTap: (){
showDialog(
context: context,
builder: (context) {
return NumberPickerDialog.integer(
minValue: 1,
maxValue: 200,
initialIntegerValue: 100,
title: Text("Select your height"),
);
}).then((value) {
if (value != null) {
setState(() {
height = value;
heightMeter = height/100;
bmi = weight / (heightMeter * heightMeter);
});
}
});
},
child: Container(
child: Material(
color: Colors.white,
elevation: 14.0,
shadowColor: Color(0x802196f3),
borderRadius: BorderRadius.circular(12.0),
child: Center(
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
children: [
Flexible(
child: Text(
"Height",style: TextStyle(fontSize: 14.0),
)),
SizedBox(
height: 5,
),
Flexible(
child: Text(
height.toString(),textAlign: TextAlign.end,  style: TextStyle(color: Color(0xff1976d2), fontSize: 16.0),
)),
],
)
),
),
))),

InkWell(
onTap: () {
Fluttertoast.showToast(msg: 'Can\'t edit your BMI');
},
child: Container(
child: Material(
color: Colors.white,
elevation: 14.0,
shadowColor: Color(0x802196f3),
borderRadius: BorderRadius.circular(12.0),
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
children: [
Flexible(
child: Text(
"BMI",style: TextStyle(fontSize: 14.0),
)),
SizedBox(
height: 5,
),
Flexible(
child: Text(
bmi.toStringAsFixed(1),textAlign: TextAlign.end,  style: TextStyle(color: Color(0xff1976d2), fontSize: 16.0),
)),
],
)
),
))),

InkWell(
onTap: (){
showDialog(
context: context,
builder: (context) {
return NumberPickerDialog.integer(
minValue: 1,
maxValue: 200,
initialIntegerValue: 100,
title: Text("Select your Blood Pressure"),
);
}).then((value) {
if (value != null) {
setState(() {
bloodPressure = value;
});
}
});
},
child: Container(
child: Material(
color: Colors.white,
elevation: 14.0,
shadowColor: Color(0x802196f3),
borderRadius: BorderRadius.circular(12.0),
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
children: [
Flexible(
child: Text(
"Blood Pressure",style: TextStyle(fontSize: 14.0),
)),
SizedBox(
height: 5,
),
Flexible(
child: Text(
bloodPressure.toString() +" hh Mg",textAlign: TextAlign.end,  style: TextStyle(color: Color(0xff1976d2), fontSize: 16.0),
)),
],
),
),
))),
// InkWell(
//     onTap: (){
//       Navigator.push(context, MaterialPageRoute(builder: (context) => SymptomCheckerScreen()));
//     },
//     child: Container(
//         child: MyItems("assets/symptom_checker.png",
//             "Symptom Checker", 0xffffffff))),
InkWell(
onTap: (){
showDialog(
context: context,
builder: (context) {
return NumberPickerDialog.integer(
minValue: 1,
maxValue: 200,
initialIntegerValue: 100,
title: Text("Select your Blood Pressure"),
);
}).then((value) {
if (value != null) {
setState(() {
pulse = value;
});
}
});
},
child: Container(
child: Material(
color: Colors.white,
elevation: 14.0,
shadowColor: Color(0x802196f3),
borderRadius: BorderRadius.circular(12.0),
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
children: [
Flexible(
child: Text(
"Pulse",style: TextStyle(fontSize: 14.0),
)),
SizedBox(
height: 5,
),
Flexible(
child: Text(
pulse.toString()+" bpm",textAlign: TextAlign.end,  style: TextStyle(color: Color(0xff1976d2), fontSize: 16.0),
)),
],
)
),
))),

InkWell(
onTap: (){
showModalBottomSheet(
context: context,
builder: (context) {
return Container(
padding: EdgeInsets.symmetric(
horizontal: 16, vertical: 10.0),
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
SizedBox(
height: 10.0,
),
Text(
"Select your blood group",
style: TextStyle(
fontWeight: FontWeight.w500,
fontSize: 18.0),
),
SizedBox(
height: 10.0,
),
Divider(
color: Colors.grey,
),
Wrap(
spacing: 10.0,
runSpacing: 10.0,
children: [
choiceChipBloodGroup(
chipLabel: "A+",
),
choiceChipBloodGroup(
chipLabel: "A-",
),
choiceChipBloodGroup(
chipLabel: "B+",
),
choiceChipBloodGroup(
chipLabel: "B-",
),
choiceChipBloodGroup(
chipLabel: "0+",
),
choiceChipBloodGroup(
chipLabel: "0-",
),
choiceChipBloodGroup(
chipLabel: "AB+",
),
choiceChipBloodGroup(
chipLabel: "AB-",
)
],
),
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Wrap(
spacing: 10.0,
runSpacing: 10.0,
children: [],
),
],
),
],
),
);
},
);
},
child: Container(
child: Material(
color: Colors.white,
elevation: 14.0,
shadowColor: Color(0x802196f3),
borderRadius: BorderRadius.circular(12.0),
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
children: [
Flexible(
child: Text(
"Blood Group",style: TextStyle(fontSize: 14.0),
)),
SizedBox(
height: 5,
),
Flexible(
child: Text(
bloodGroup,textAlign: TextAlign.end,  style: TextStyle(color: Color(0xff1976d2), fontSize: 16.0),
)),
],
)
),
))),
],
staggeredTiles: [
StaggeredTile.extent(2, 70.0), //appointment
StaggeredTile.extent(1, 70.0), //ehr
StaggeredTile.extent(1, 70.0), //healthcheckup
StaggeredTile.extent(1, 70.0), //find services
StaggeredTile.extent(1, 70.0),
StaggeredTile.extent(1, 70.0),
StaggeredTile.extent(1, 70.0),
StaggeredTile.extent(1, 70.0),
//StaggeredTile.extent(1, 70.0),
//StaggeredTile.extent(1, 70.0)
],
),
],
),
);*/
