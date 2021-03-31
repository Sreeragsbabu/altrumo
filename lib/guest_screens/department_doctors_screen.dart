import 'package:demo_altrumo/alert_dialogs/guest_login_alert.dart';
import 'package:demo_altrumo/appointment_models/doctors.dart';
import 'package:demo_altrumo/services/guest_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuestDepartmentDoctors extends StatefulWidget {
  final String specialityName;
  final int id;

  const GuestDepartmentDoctors({Key key, this.specialityName, this.id}) : super(key: key);
  @override
  _GuestDepartmentDoctorsState createState() => _GuestDepartmentDoctorsState();
}

class _GuestDepartmentDoctorsState extends State<GuestDepartmentDoctors> {
  bool guestLoading = false;
  List<SpecDoctors> specialityConsultants;
  String depId;
  @override
  void initState() {
    guestLoading = true;
    loadConsultants();
    // TODO: implement initState
    super.initState();
  }
  loadConsultants() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    depId = widget.id.toString();
    GuestServices.getSpecialityConsultants(depId).then((doc) {
      if (this.mounted) {
        setState(() {
          specialityConsultants = doc;
          print(specialityConsultants);
          guestLoading = false;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.specialityName),
      ),
      body: guestLoading? Center(child: CircularProgressIndicator()):Container(
        child: specialityConsultants.isEmpty? Center(
            child: Text(
                "Currently no doctors available in this Hospital")):
        ListView.builder(
          itemCount: specialityConsultants.length,
          itemBuilder: (context, index){
            return  GestureDetector(
              onTap: (){
                /*Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorDetailsScreen(
                      name: guestConsultants[index].employeeName,
                      category: guestConsultants[index].departmentName,
                      uhid: uhid,
                      docId: guestConsultants[index].id,
                      docName: guestConsultants[index].employeeName,
                      patientName: pName,
                      doctors: guestConsultants,
                      experience: 5,
                      likes: 230,
                      imageUrl: "assets/doctor_img.jpg",
                      depId: guestConsultants[index].departmentId,)
                    ));*/
              },
              child: Card(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage: AssetImage("assets/doctor_img.jpg"),
                                ),

                                SizedBox(height: 8.0,),
                                Container(
                                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                                    width: 40,
                                    height: 18,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2.0),
                                        // border: Border.all(color: Colors.black54),
                                        shape: BoxShape.rectangle,
                                        color: Colors.orange),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.star,color: Colors.white,size: 12.0,),
                                        Flexible(child: Text(4.3.toString(),style: TextStyle(color: Colors.white, fontSize: 12.0),))
                                      ],
                                    )
                                )
                              ],
                            ),
                            SizedBox(width: 16.0,),
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(specialityConsultants[index].employeeName,style: TextStyle(fontSize: 18.0),),
                                  SizedBox(height: 4.0,),
                                  Text(specialityConsultants[index].departmentName,style: TextStyle(color: Colors.black54),),
                                  SizedBox(height: 4.0,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.location_on, color: Colors.black54,size: 14.0,),
                                      SizedBox(width: 4.0,),
                                      Text("Location",style: TextStyle(color: Colors.black54),)
                                    ],
                                  )

                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10.0,),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Experience",style: TextStyle(color: Colors.black54,fontSize: 16.0),),
                                    SizedBox(height: 4.0,),
                                    Text(5.toString()+" years")
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Column(
                                  children: [
                                    Text("Likes",style: TextStyle(color: Colors.black54,fontSize: 16.0),),
                                    SizedBox(height: 4.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(230.toString()),
                                        SizedBox(width: 4.0,),
                                        Icon(Icons.thumb_up,size: 14.0,color: Colors.black54,),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: FlatButton(
                                    height: 30,
                                    onPressed: () async{
                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible: true,
                                        // false = user must tap button, true = tap outside dialog
                                        builder: (BuildContext dialogContext) {
                                          return GuestLoginAlert();
                                        },
                                      );

                                      /*bookDoctorBottomSheet
                                            (guestConsultants[index].employeeName,
                                              guestConsultants[index].departmentName,
                                              guestConsultants[index].id,
                                              guestConsultants[index].departmentId,
                                              "assets/doctor_img.jpg");*/

                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentScreen()));
                                    },

                                    color: Colors.blue,
                                    child: Text("Book",style: TextStyle(color: Colors.white),),
                                  ),
                                )
                            )
                          ],
                        )
                      ],
                    ),
                  )
              ),
            );
          },
        ),
      ),
    );
  }


}
