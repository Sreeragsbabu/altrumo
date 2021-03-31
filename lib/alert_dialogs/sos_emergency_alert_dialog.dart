import 'package:demo_altrumo/services/common_services.dart';
import 'package:flutter/material.dart';
import 'package:demo_altrumo/models/hospitals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SosEmergencyAlertDialog extends StatefulWidget {
  /*List<Hospitals> hospitals = [
    Hospitals(name:"Altrumo Hospital", code: "J P Nagar",id: 9539436304),
    Hospitals(name:"Altrumo Hospital", code: "M G Road", id: 999123897),
    Hospitals(name:"Altrumo Hospital", code: "WhiteField", id: 9846574392),
    Hospitals(name:"Altrumo Hospital", code: "BrookeField", id: 8879120945),

  ];*/
  @override
  _SosEmergencyAlertDialogState createState() => _SosEmergencyAlertDialogState();
}

class _SosEmergencyAlertDialogState extends State<SosEmergencyAlertDialog> {
  List<Hospitals> hospitals;
  bool _loading = false;
  @override
  void initState() {
    _loading = true;
    loadHospitals();
    // TODO: implement initState
    super.initState();
  }
  loadHospitals() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString('token');
    HospitalLocationServices.getHospitals(tokenId).then((hosp) {
      if(this.mounted){
        setState(() {
          hospitals = hosp;
          print(hospitals);
          _loading = false;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("SOS / Emergency Contact Number",style: TextStyle(
                color: Color(0xff1976d2),
                fontSize: 14.0)),
            Divider(color: Colors.grey,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Hospital Name",style: TextStyle(
                    color: Color(0xffff9800),
                    fontSize: 14.0)),
                Text("Contact No.",style: TextStyle(
                    color: Color(0xffff9800),
                    fontSize: 14.0))                                         ],
            ),
            Divider(color: Colors.grey,),
            //SizedBox(height: 8.0,),
            _loading? Center(child: CircularProgressIndicator()): Column(
              mainAxisSize: MainAxisSize.min,
              children: hospitals.map((e) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                     // SizedBox(height: 10.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e.name,style: TextStyle(
                                    color: Color(0xff1976d2),
                                    fontSize: 14.0)),
                                /*Text(e.code,style: TextStyle(
                                    color: Color(0xff1976d2),
                                    fontSize: 14.0)),*/
                              ],
                            ),
                          ),
                          Text("+91 "+ e.phone1.toString(),style: TextStyle(
                              color: Color(0xff1976d2),
                              fontSize: 14.0))
                        ],
                      ),
                      Divider(color: Colors.grey,),
                    ],
                  ),
                );
              }).toList(),
            )
            /* GestureDetector(
                                          onTap: (){
                                            launch("tel:101");
                                          },
                                          child: Text('Ambulance',style: TextStyle(
                                              color: Color(0xffff9800),
                                              fontSize: 16.0)),
                                        ),*/
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context)
                  .pop(); // Dismiss alert dialog
            },
          ),
        ]

    );
  }
}
