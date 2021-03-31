import 'package:demo_altrumo/appointment_models/time_slots.dart';
import 'package:demo_altrumo/services/appointment_services.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import 'confirm_booking.dart';

class TimeSlot extends StatefulWidget {
  final String pName, uhid, conType, speciality, doctName;
  final int deptId, docId;

  const TimeSlot(
      {Key key,
      this.pName,
      this.uhid,
      this.conType,
      this.speciality,
      this.deptId,
      this.docId,
      this.doctName})
      : super(key: key);
  @override
  _TimeSlotState createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot> {
  String docName = "";
  String startTime = "";
  String endTime = "";
  String conId='';
  String deptName = "";
  int selectedIndex = -1;
  DateTime initialTime = DateTime.now();
  String formattedDate='';
  String token = "";
  List<TimeSlots> timeSlots;
  bool _loading;
  String depId='';
  @override
  void initState() {
    loadName();

    _loading = true;
  }

  loadName() async {
    formattedDate = DateFormat('yyyy-MM-dd').format(initialTime);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString('token');
     depId = widget.deptId.toString();
     conId = widget.docId.toString();
    token = tokenId;
    print(conId);
    print(depId);
    print(formattedDate);
    print("111111" + token);
    AppointmentServices.getTimeSlots(
            token, conId, depId, formattedDate)
        .then((tslots) {
      if (this.mounted) {
        setState(() {
          timeSlots = tslots;
          print(timeSlots);
          _loading = false;
        });
      }
    });
  }

  changeDate(String conId, String depId, String formattedDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString('token');
    token = tokenId;
    AppointmentServices.getTimeSlots(
        token, conId, depId, formattedDate)
        .then((tslots) {
      if (this.mounted) {
        setState(() {
          timeSlots = tslots;
          print(timeSlots);
          _loading = false;
        });
      }
    });
  }

  DateTime _selectedValue;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Time Slots"),
          ),
          bottomNavigationBar: nextButton(),
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

                        Divider(color: Colors.grey,),
                        Row(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Text("Speciality :", style: TextStyle(fontSize: 16.0),)),
                            Flexible(
                              child: Container(
                                  padding: EdgeInsets.only(left: 16.0),
                                  child:  Text(

                                    widget.speciality,
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
                                child: Text("Consultant :", style: TextStyle(fontSize: 16.0),)),
                            Flexible(
                              child: Container(
                                  padding: EdgeInsets.only(left: 16.0),
                                  child:  Text(

                                    widget.doctName,
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
                Align(
                    alignment: Alignment.center,
                    child: Text("Select the Date ",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold))),
                Divider(
                  color: Colors.grey,
                ),
                DatePicker(
                  DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.blue,
                  selectedTextColor: Colors.white,
                  deactivatedColor: Colors.grey,
                  onDateChange: (date) {
                    // New date selected
                    setState(() {
                      _selectedValue = date;
                      print(_selectedValue);
                      String depId = widget.deptId.toString();
                      String conId = widget.docId.toString();
                      formattedDate = DateFormat('yyyy-MM-dd').format(_selectedValue);
                      print(depId);
                      print(conId);
                      print(formattedDate);
                      changeDate(conId,depId, formattedDate);
                    });
                  },
                ),
                Divider(
                  color: Colors.grey,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Text("Available Slots",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold))),
                SizedBox(
                  height: 16.0,
                ),
                Expanded(
                  child: Container(
                    child: _loading
                        ? Center(child: CircularProgressIndicator())
                        : Container(
                          child: timeSlots.isEmpty ? Center(child: Text("Currently no time slots available for this doctor")) :GridView.builder(
                              itemCount: timeSlots.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 5.0,
                                mainAxisSpacing: 5.0,
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                      startTime = timeSlots[index].startTime;
                                      endTime = timeSlots[index].endTime;
                                      print(timeSlots[index].startTime);
                                      print(timeSlots[index].endTime);
                                    });
                                  },
                                  child: Card(
                                    shape: (selectedIndex == index)
                                        ? RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            side: BorderSide(
                                                color: Colors.blue, width: 4.0))
                                        : RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                    elevation: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Flexible(
                                                child: Text(
                                                    timeSlots[index].startTime)),
                                          ],
                                        ),
                                      ),
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
          )),
    );
  }

  nextButton() {
    return GestureDetector(
      onTap: () {
        if (selectedIndex == -1) {
          Fluttertoast.showToast(
              msg: "Please select a time slot");
        } else {
          print(docName);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ConfirmBooking(
                    pName: widget.pName,
                    uhid: widget.uhid,
                    conType: widget.conType,
                    speciality: widget.speciality,
                    deptId: widget.deptId,
                    doctName: widget.doctName,
                    docId: widget.docId,
                    time: startTime,
                    date: formattedDate,
                  )));
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 48,
        width: MediaQuery.of(context).size.width,
        color: Color(0xff1976d2),
        child: Text(
          "Book Appointment",
          style: TextStyle(color: Colors.white, fontSize: 14.0),
        ),
      ),
    );
  }
}
