import 'package:demo_altrumo/alert_dialogs/appointment_confirm_alert.dart';
import 'package:demo_altrumo/appointment_models/apointment_response.dart';
import 'package:demo_altrumo/services/appointment_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmBooking extends StatefulWidget {
  final String pName, uhid, conType, speciality, doctName, date, time;
  final int deptId, docId;

  const ConfirmBooking(
      {Key key,
      this.pName,
      this.uhid,
      this.conType,
      this.speciality,
      this.doctName,
      this.deptId,
      this.docId,
      this.time,
      this.date})
      : super(key: key);
  @override
  _ConfirmBookingState createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  AppointmentResponse apptsResponse;
  bool _loading;
  String token = "";
  String deptId = "";
  String conId = "";
  String hospId;
  String userrId = '';
  String hospitalName = '';
  @override
  void initState() {
    loadName();

    _loading = true;
  }

  loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString('token');
    var hospitalId = prefs.getInt('hospitalId').toString();
    var hospName = prefs.getString('hospitalName').toString();
    var userId = prefs.getString('userId');
    deptId = widget.deptId.toString();
    conId = widget.docId.toString();
    setState(() {
      token = tokenId;
      hospId = hospitalId;
      userrId = userId;
      hospitalName = hospName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Confirm"),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xff1976d2)),
                child: Center(
                    child: Text(
                  "Hi ${widget.pName} please confirm the below appointment details",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                )),
              ),
              SizedBox(
                height: 12.0,
              ),
              Card(
                elevation: 8.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                "Patient Name :",
                                style: TextStyle(fontSize: 16.0),
                              )),
                          Flexible(
                            child: Container(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text(
                                  widget.pName + userrId,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                )),
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                "UHID : ",
                                style: TextStyle(fontSize: 16.0),
                              )),
                          Flexible(
                            child: Container(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text(
                                  widget.uhid,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                )),
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                "Type :",
                                style: TextStyle(fontSize: 16.0),
                              )),
                          Flexible(
                            child: Container(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text(
                                  widget.conType,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                )),
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                "Speciality :",
                                style: TextStyle(fontSize: 16.0),
                              )),
                          Flexible(
                            child: Container(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text(
                                  widget.speciality,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                )),
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                "Consultant :",
                                style: TextStyle(fontSize: 16.0),
                              )),
                          Flexible(
                            child: Container(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text(
                                  widget.doctName,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                )),
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                "Time :",
                                style: TextStyle(fontSize: 16.0),
                              )),
                          Flexible(
                            child: Container(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text(
                                  widget.time,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                )),
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(
                                "Date :",
                                style: TextStyle(fontSize: 16.0),
                              )),
                          Flexible(
                            child: Container(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text(
                                  widget.date,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              ElevatedButton(
                  child: new Text("Confirm Booking"),
                  onPressed: () {
                    _loading = false;
                    AppointmentServices.confirmAppointment(
                            token,
                            widget.uhid,
                            conId,
                            deptId,
                            widget.date,
                            widget.time,
                            hospId,
                            userrId,
                            context,
                            hospitalName,
                            widget.pName,
                            widget.doctName,
                            widget.speciality,
                    widget.conType)
                        .then((appts) {
                      if (this.mounted) {
                        setState(() {
                          apptsResponse = appts;
                          print(apptsResponse);
                          _loading = false;
                          /*showDialog<void>(
                              context: context,
                              barrierDismissible: true,
                              // false = user must tap button, true = tap outside dialog
                              builder: (BuildContext dialogContext) {
                                return AppointmentConfirmDialog(
                                  context: context,
                                  name: widget.pName,
                                  date: widget.date,
                                  // hospitalName: selectedBranch,
                                  hospitalName: "Hospital name",
                                  consultantName:widget.doctName ,
                                  specialityName: "Speciality",
                                  time: widget.time,
                                  imageUrl: "assets/pro_pic.png",
                                  consultType: "audio",
                                );
                              },
                            );*/
                        });
                      }
                    });
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              side: BorderSide(color: Colors.red))))),
            ],
          ),
        ),
      ),
    );
  }
}
