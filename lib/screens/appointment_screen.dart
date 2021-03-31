import 'package:demo_altrumo/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:demo_altrumo/alert_dialogs/appointment_confirm_alert.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:demo_altrumo/models/doctors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'phone_auth_screen.dart';
import 'package:demo_altrumo/screens/login_screen.dart';

class AppointmentScreen extends StatefulWidget {
  final Function changeTabFunction;
  const AppointmentScreen({Key key, this.changeTabFunction}) : super(key: key);

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  String displayHospitalName ="";
  String displayHospitalLocation ="";
  @override
  void initState() {
    loadHospitalName();
  }
  loadHospitalName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dispName = prefs.getString('displayName');
    var hospName = prefs.getString('hospitalName');
    var hospLocation = prefs.getString('hospitalLocation');
    setState(() {
      displayHospitalName = hospName;
      displayHospitalLocation= hospLocation;
    });

  }

  //String selectedTime;
  //List timeSlots = ["10:00 AM", "11:00 AM", "12:00 PM", "01:00 PM","02::00 PM", "03:00 PM", "04:00 PM","05:00 PM", "06:00 PM", "07:00 PM"];
  String selectedType;
  List typesofConsultation = ["Audio", "Video", "Physical"];
  //String selectedBranch;
  //List branches = ["Ninewells Hospital", "Ruhunu Hospital", "Lanka Hospital", "A.N. Hospital","Chedikkulam Hospital"];

  String selectedCategory;
  List specialities = ["Physician", "Gynaecology", "Dermatology", "Pediatrics","Cardiology", "Physiotherapy", "Dentist"];

  String selectedDoctor;
  List doctors = ["Dr. Sita Kariyavasam", "Dr. M. Harish Muniyappa", "Dr. Chanditha Amarasinghe", "Dr. K.W.A.A Jayawardena", "Hasanthi Ruberu"];

  final patientNameController = TextEditingController();
  final descriptionController = TextEditingController();


  TimeOfDay _currentTime = TimeOfDay.now();
  TimeOfDay pickedDate;
  String timePeriod = TimeOfDay.now().period == DayPeriod.am? "AM":"PM";

  Future<Null> selectTime(BuildContext context)async{
    pickedDate = await showTimePicker(
      context: context,
      initialTime: _currentTime
    );

    if(pickedDate != null && pickedDate != _currentTime){
      setState(() {
        _currentTime = pickedDate.replacing(hour: pickedDate.hourOfPeriod);
      });
      if(pickedDate.period == DayPeriod.am){
        timePeriod = "AM";
      }
      else{
        timePeriod = "PM";
      }

    }

  }


  DateTime date = DateTime.now();
  var convertedDate = DateFormat.yMMMd().format(DateTime.now());
  Future<void> selectTimePicker(BuildContext context) async{
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime(2025),
    );
    if(pickedDate != null && pickedDate != date){
      setState(() {
        date=pickedDate;
         convertedDate = DateFormat.yMMMd().format(date);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: submitButton(),
        appBar: AppBar(
          title: Text("Appointment Request"),
        ),


 body: Container(
   padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 12.0),
   height: MediaQuery.of(context).size.height,
   child: ListView(
     shrinkWrap: true,
     children: [
       patientNameRow(),
       SizedBox(height: 10.0,),
       datePickerRow(),
       SizedBox(height: 10.0,),
       timePickerRow(),
       SizedBox(height: 10.0,),
       typeSelectRow(),
       /*SizedBox(height: 10.0,),
       branchSelectRow(),*/
       SizedBox(height: 10.0,),
       specialitySelectRow(),
       SizedBox(height: 10.0,),
       doctorsSelectRow(),
       SizedBox(height: 10.0,),
       descriptionRow(),
       SizedBox(height: 10.0,),

     ],
   ),
 ),

      // body: Container(
      //   height: MediaQuery.of(context).size.height,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       ListView(
      //         shrinkWrap: true,
      //         children: [
      //           patientNameRow(),
      //           SizedBox(height: 10.0,),
      //           datePickerRow(),
      //           SizedBox(height: 10.0,),
      //           ApptTimeRow(),
      //           SizedBox(height: 10.0,),
      //           branchSelectRow(),
      //           SizedBox(height: 10.0,),
      //           specialitySelectRow(),
      //           SizedBox(height: 10.0,),
      //           doctorsSelectRow(),
      //           SizedBox(height: 10.0,),
      //           descriptionRow(),
      //         ],
      //       ),
      //
      //     ],
      //   ),
      //
      // ),
      ),
    );
  }

  patientNameRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Text("Patient", style: TextStyle(fontSize: 16.0),)),
        Flexible(
          child: Container(
          padding: EdgeInsets.only(left: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.black54)
            ),
            child: TextField(
              decoration: InputDecoration(

                border: InputBorder.none,
                hintText: "Name"
              ),
              controller: patientNameController,
            ),
          ),
        )
      ],
    );
  }

  datePickerRow() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Text("Date", style: TextStyle(fontSize: 16.0),)),
        Expanded(
          child: GestureDetector(
            onTap: (){
              selectTimePicker(context);
            },
            child: Container(
              height: 50.0,
              padding: EdgeInsets.only(left: 16.0,right: 20.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black54)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: Text(DateFormat.yMMMd().format(date))),
                  Icon(Icons.calendar_today_outlined,color: Colors.black54,)
                ],
              )
            ),
          ),
        )
      ],
    );
  }

  timePickerRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Text("Time", style: TextStyle(fontSize: 16.0),)),
        Expanded(
          child: GestureDetector(
            onTap: (){
              selectTime(context);
            },
            child: Container(
                height: 50.0,
                padding: EdgeInsets.only(left: 16.0,right: 20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.black54)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Text("${_currentTime.format(context).substring(0,5)}"+" ${timePeriod}")),
                    Icon(Icons.timer_rounded,color: Colors.black54,)
                  ],
                )
            ),
          ),
        )
      ],
    );
  }


 /* ApptTimeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Text("Appt. Time", style: TextStyle(fontSize: 16.0),)),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            decoration:
            BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black54)),
            child: DropdownButtonFormField(
              decoration: InputDecoration(enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))),
              elevation: 10,
              isExpanded: true,
              dropdownColor: Colors.white,
              hint: Text("Select Time"),
              value: selectedTime,
              onChanged: (value) {
                setState(() {
                  selectedTime = value;
                });
              },
              items: timeSlots.map((value) {
                return DropdownMenuItem(

                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }*/

  typeSelectRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Text("Type", style: TextStyle(fontSize: 16.0),)),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            decoration:
            BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black54)),
            child: DropdownButtonFormField(

              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))),
              elevation: 10,
              isExpanded: true,
              dropdownColor: Colors.grey.shade300,
              hint: Text("Select Type"),
              value: selectedType,
              onChanged: (value) {
                setState(() {
                  selectedType = value;
                });
              },
              items: typesofConsultation.map((value) {
                return DropdownMenuItem(

                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }

  /*branchSelectRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Text("Hospital", style: TextStyle(fontSize: 16.0),)),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            decoration:
            BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black54)),
            child: DropdownButtonFormField(

              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))),
              elevation: 10,
              isExpanded: true,
              dropdownColor: Colors.grey.shade300,
              hint: Text("Select Hospital"),
              value: selectedBranch,
              onChanged: (value) {
                setState(() {
                  selectedBranch = value;
                });
              },
              items: branches.map((value) {
                return DropdownMenuItem(

                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }*/

  specialitySelectRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Text("Speciality", style: TextStyle(fontSize: 16.0),)),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            decoration:
            BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black54)),
            child: DropdownButtonFormField(
              decoration: InputDecoration(enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))),
              elevation: 10,
              isExpanded: true,
              dropdownColor: Colors.white,
              hint: Text("Select Category"),
              value: selectedCategory,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
              items: specialities.map((value) {
                return DropdownMenuItem(

                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }

  doctorsSelectRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Text("Consultant", style: TextStyle(fontSize: 16.0),)),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            decoration:
            BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black54)),
            child: DropdownButtonFormField(
              decoration: InputDecoration(enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))),
              elevation: 10,
              isExpanded: true,
              dropdownColor: Colors.white,
              hint: Text("Pick your Doctor"),
              value: selectedDoctor,
              onChanged: (value) {
                setState(() {
                  selectedDoctor = value;
                });
              },
              items: doctors.map((value) {
                return DropdownMenuItem(

                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }

  descriptionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Text("Description", style: TextStyle(fontSize: 16.0),)),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(left: 16.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.black54)
            ),
            child: TextField(

              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: ""
              ),
              controller: descriptionController,
            ),
          ),
        )
      ],
    );
  }

  submitButton() {
    return GestureDetector(
      onTap: () async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var isGuest = prefs.getString('displayName');
        if(isGuest =="Guest"){
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
          try{
            if(patientNameController.text.isNotEmpty
                // && selectedBranch.isNotEmpty
                && selectedDoctor.isNotEmpty
                && selectedCategory.isNotEmpty
                && _currentTime != null
            )
            {
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                // false = user must tap button, true = tap outside dialog
                builder: (BuildContext dialogContext) {
                  return AppointmentConfirmDialog(
                    context: context,
                    name: patientNameController.text,
                    date: convertedDate,
                    // hospitalName: selectedBranch,
                    hospitalName: displayHospitalName +", "+displayHospitalLocation,
                    consultantName:selectedDoctor ,
                    specialityName: selectedCategory,
                    time: "${_currentTime.format(context).substring(0,5)}"+" ${timePeriod}",
                    imageUrl: "assets/pro_pic.png",
                    consultType: selectedType,
                  );
                },
              );
            }
            else{
              Fluttertoast.showToast(msg: "Enter all the required details");
            }
          }
          catch(exception){
            Fluttertoast.showToast(msg: "Enter all the required details");
            print(exception);
          }
        }


      },
      child: Container(
        alignment: Alignment.center,
        height: 48,
        width: MediaQuery.of(context).size.width,
        color: Color(0xff1976d2),
        child: Text(
          "Submit",
          style: TextStyle(color: Colors.white, fontSize: 14.0),
        ),
      ),
    );
  }


}
