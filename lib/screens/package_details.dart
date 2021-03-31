import 'package:flutter/material.dart';

class PackageDetailsScreen extends StatelessWidget {
  final String pacName;
  /*final String pacCode;
  final String pacCategory;*/

  const PackageDetailsScreen({Key key, this.pacName,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(pacName),

        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
             /* Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(child: Text("Code"))),
                  Expanded(
                      flex: 2,
                      child: Container(child: Text(pacCode))),
                ],
              ),
              SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(child: Text("Name"))),
                  Expanded(
                      flex: 2,
                      child: Container(child: Text(pacName))),
                ],
              ),
              SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(child: Text("Category"))),
                  Expanded(
                      flex: 2,
                      child: Container(child: Text(pacCategory))),
                ],
              ),*/
              Spacer(),
              FlatButton(
                onPressed: () {
                  // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyAppointmentTabScreen()),
                  //     (ModalRoute.withName("/my_appointment")));
                },
                child: Text("Book"),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                color: Color(0xff1976d2),
                textColor: Colors.white,
              )

            ],
          ),
        ),
      ),
    );
  }
}
