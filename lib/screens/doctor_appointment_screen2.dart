import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:demo_altrumo/alert_dialogs/appointment_confirm_alert.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:demo_altrumo/models/doctors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDoctorAppointmentScreen extends StatefulWidget {
  final String consultationType;
  final String docName;
  final String docCategory;
  // final String docHospital;
  final String docImageUrl;

  const MyDoctorAppointmentScreen(
      {Key key,
      this.consultationType,
      this.docName,
      this.docCategory,
     // this.docHospital,
      this.docImageUrl})
      : super(key: key);
  @override
  _MyDoctorAppointmentScreenState createState() =>
      _MyDoctorAppointmentScreenState();
}

class _MyDoctorAppointmentScreenState extends State<MyDoctorAppointmentScreen> {
  String displayHospitalName = "";
  String displayHospitalLocation = "";
  @override
  void initState() {
    loadHospitalName();
  }

  loadHospitalName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var dispName = prefs.getString('displayName');
    var hospName = prefs.getString('hospitalName');
    var hospLocation = prefs.getString('hospitalLocation');
    setState(() {
      displayHospitalName = hospName;
      displayHospitalLocation = hospLocation;
    });
  }

  final patientNameController = TextEditingController();
  final descriptionController = TextEditingController();
  TimeOfDay _currentTime = TimeOfDay.now();
  TimeOfDay pickedDate;
  String timePeriod = TimeOfDay.now().period == DayPeriod.am ? "AM" : "PM";

  Future<Null> selectTime(BuildContext context) async {
    pickedDate =
        await showTimePicker(context: context, initialTime: _currentTime);

    if (pickedDate != null && pickedDate != _currentTime) {
      setState(() {
        _currentTime = pickedDate.replacing(hour: pickedDate.hourOfPeriod);
      });
      if (pickedDate.period == DayPeriod.am) {
        timePeriod = "AM";
      } else {
        timePeriod = "PM";
      }
    }
  }

  DateTime date = DateTime.now();
  var convertedDate = DateFormat.yMMMd().format(DateTime.now());
  Future<void> selectTimePicker(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null && pickedDate != date) {
      setState(() {
        date = pickedDate;
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
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          height: MediaQuery.of(context).size.height,
          child: ListView(
            shrinkWrap: true,
            children: [
              patientNameRow(),
              SizedBox(
                height: 10.0,
              ),
              datePickerRow(),
              SizedBox(
                height: 10.0,
              ),
              timePickerRow(),
              SizedBox(
                height: 10.0,
              ),
              descriptionRow(),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  patientNameRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Text(
              "Patient",
              style: TextStyle(fontSize: 16.0),
            )),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(left: 16.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.black54)),
            child: TextField(
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: "Name"),
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
            child: Text(
              "Date",
              style: TextStyle(fontSize: 16.0),
            )),
        Expanded(
          child: GestureDetector(
            onTap: () {
              selectTimePicker(context);
            },
            child: Container(
                height: 50.0,
                padding: EdgeInsets.only(left: 16.0, right: 20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.black54)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Text(DateFormat.yMMMd().format(date))),
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.black54,
                    )
                  ],
                )),
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
            child: Text(
              "Time",
              style: TextStyle(fontSize: 16.0),
            )),
        Expanded(
          child: GestureDetector(
            onTap: () {
              selectTime(context);
            },
            child: Container(
                height: 50.0,
                padding: EdgeInsets.only(left: 16.0, right: 20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.black54)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                            "${_currentTime.format(context).substring(0, 5)}" +
                                " ${timePeriod}")),
                    Icon(
                      Icons.timer_rounded,
                      color: Colors.black54,
                    )
                  ],
                )),
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
            child: Text(
              "Description",
              style: TextStyle(fontSize: 16.0),
            )),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(left: 16.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.black54)),
            child: TextField(
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: ""),
              controller: descriptionController,
            ),
          ),
        )
      ],
    );
  }

  submitButton() {
    return GestureDetector(
      onTap: () {
        try {
          if (patientNameController.text.isNotEmpty
              //&& selectedBranch.isNotEmpty
              //&& selectedDoctor.isNotEmpty
              //&& selectedCategory.isNotEmpty
              &&
              _currentTime != null &&
              descriptionController.text.isNotEmpty) {
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              // false = user must tap button, true = tap outside dialog
              builder: (BuildContext dialogContext) {
                return AppointmentConfirmDialog(
                  context: context,
                  name: patientNameController.text,
                  date: convertedDate,
                 // hospitalName: widget.docHospital,
                  hospitalName: displayHospitalName +", " +displayHospitalLocation,
                  consultantName: widget.docName,
                  specialityName: widget.docCategory,
                  time: "${_currentTime.format(context).substring(0, 5)}" +
                      " ${timePeriod}",
                  imageUrl: widget.docImageUrl,
                  consultType: widget.consultationType,
                );
              },
            );
          } else {
            Fluttertoast.showToast(msg: "Enter all the required details");
          }
        } catch (exception) {
          Fluttertoast.showToast(msg: "Enter all the required details");
          print(exception);
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
