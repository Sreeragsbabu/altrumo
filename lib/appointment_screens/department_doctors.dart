import 'package:demo_altrumo/appointment_models/doctors.dart';
import 'package:demo_altrumo/services/appointment_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'time_slot.dart';

class DepartmentDoctors extends StatefulWidget {
  final String pName, uhid, conType, speciality;
  final int deptId;

  const DepartmentDoctors(
      {Key key,
      this.pName,
      this.uhid,
      this.conType,
      this.speciality,
      this.deptId})
      : super(key: key);
  @override
  _DepartmentDoctorsState createState() => _DepartmentDoctorsState();
}

class _DepartmentDoctorsState extends State<DepartmentDoctors> {
  String docName = "";
  int docId;
  String deptName = "";
  int selectedIndex = -1;

  String token = "";
  List<SpecDoctors> doctors;
  bool _loading;
  String depId ='';
  @override
  void initState() {
    loadName();
    _loading = true;
  }

  loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString('token');
    //var hospitalId = prefs.getInt('hospitalId').toString();
    depId = widget.deptId.toString();
    token = tokenId;
    print("111111" + token);
    AppointmentServices.getDoctors(token, depId).then((doc) {
      if (this.mounted) {
        setState(() {
          doctors = doc;
          print(doctors);
          _loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All ${widget.speciality}"),
      ),
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
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 16.0,
            ),

            Align(
                alignment: Alignment.center,
                child: Text("Select the Doctor ",
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
                      child: doctors.isEmpty ? Center(child: Text("Currently no doctors available in this speciality")) :ListView.builder(
                          itemCount: doctors.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  docName = doctors[index].employeeName;
                                  deptName = doctors[index].departmentName;
                                  docId = doctors[index].id;
                                  print(doctors[index].employeeName);
                                  print(doctors[index].id);
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TimeSlot(
                                          pName: widget.pName,
                                          uhid: widget.uhid,
                                          conType: widget.conType,
                                          speciality: widget.speciality,
                                          deptId: widget.deptId,
                                          doctName: docName,
                                          docId: docId,
                                        )));
                              },
                              child: Card(
                                shape: (selectedIndex == index)
                                    ? RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        side: BorderSide(
                                            color: Colors.blue, width: 4.0))
                                    : RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                elevation: 10,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10.0),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(8.0),
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          AssetImage("assets/doctor_img.jpg"),
                                      radius: 30.0,
                                    ),
                                    title: Text(
                                        doctors[index].employeeName ?? "hai"),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(doctors[index].departmentName ??
                                            "hai"),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today_rounded,
                                              color: Colors.grey,
                                              size: 14.0,
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Expanded(
                                                child: Text(
                                              doctors[index].availableDays ??
                                                  "hai",
                                              style: TextStyle(fontSize: 12.0),
                                            )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        RatingBar.builder(
                                          itemSize: 16.0,
                                          initialRating: 4.5,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 0.5),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        )
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
      ),
      //bottomNavigationBar: nextButton(),
    );
  }

  /*nextButton() {
    return GestureDetector(
      onTap: () {
        if (selectedIndex == -1) {
          Fluttertoast.showToast(
              msg: "Please select which Speciality you want.");
        } else {
          print(docName);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TimeSlot(
                        pName: widget.pName,
                        uhid: widget.uhid,
                        conType: widget.conType,
                        speciality: widget.speciality,
                        deptId: widget.deptId,
                        doctName: docName,
                        docId: docId,
                      )));
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
}
