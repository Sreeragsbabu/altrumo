import 'package:demo_altrumo/my_appointment_tabs/my_appointment_tab_screen.dart';
import 'package:demo_altrumo/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:demo_altrumo/Constants/constants.dart';
import 'package:pimp_my_button/pimp_my_button.dart';

class AppointmentConfirmDialog extends StatelessWidget {
   final BuildContext context;
  final String name;
  final String date;
  final String time;
  final String hospitalName;
  final String specialityName;
  final String consultantName;
  //final String description;
  final String imageUrl;
  final String consultType;

  const AppointmentConfirmDialog(
      {
        @required this.context,
        @required this.name,
        @required this.date,
        @required this.time,
        @required this.hospitalName,
        @required this.specialityName,
        @required this.consultantName,
        this.imageUrl, this.consultType,})
      ;

  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          cardContent(),
          circleImage()
        ],
      ),
    );
  }

  cardContent() {
    return Container(
      padding: EdgeInsets.only(left: Consts.padding,top: Consts.avatarRadius
          + Consts.padding, right: Consts.padding,bottom: Consts.padding
      ),
      margin: EdgeInsets.only(top: Consts.avatarRadius),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(Consts.padding),
          boxShadow: [
            BoxShadow(color: Colors.black,offset: Offset(0,10),
                blurRadius: 10
            ),
          ]
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("Thank You! " + name,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
          SizedBox(height: 8,),
          Text("Your booking is confirmed",style: TextStyle(color: Colors.black54),textAlign: TextAlign.center,),
          /*SizedBox(height: 8,),
          Text("Booking Id ",style: TextStyle(color: Colors.black54),),*/
          //SizedBox(height: 8,),
          Divider(color: Colors.grey,),
          heading1row(),
          SizedBox(height: 8,),
          value1row(),
          SizedBox(height: 10,),
          headingrow2(),
          SizedBox(height: 8,),
          value2row(),
          //SizedBox(height: 8,),
          Divider(color: Colors.grey,),
          //SizedBox(height: 8,),
          doctorDetailsRow(),
          //SizedBox(height: 8,),
          Divider(color: Colors.grey,),
          //SizedBox(height: 6,),
          //descriptionRow(),
         // Divider(color: Colors.grey,),
          PimpedButton(particle: RectangleDemoParticle(), pimpedWidgetBuilder: (context,controller){
            return FlatButton(
              onPressed: () {
                controller.forward(from: 0.0);
                print("aaaa");
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen(currentIndex: 1,)),
                    (ModalRoute.withName("/my_appointment")));
                // Navigator.pushReplacementNamed(context, "/my_appointment");
                //Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppointmentTabScreen()));
              },
              child: Text("Done"),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              color: Color(0xff1976d2),
              textColor: Colors.white,
            );
          })



        ],
      ),
    );
  }

  circleImage() {
    return Positioned(
        left: Consts.padding,
        right: Consts.padding,
        child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: Consts.avatarRadius,
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(Consts.avatarRadius)),
            child: Image.asset("assets/success.png")
        ),
    ));
  }

  heading1row() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("VISIT DATE",style: TextStyle(color: Colors.black54),),
        Text("TIME",style: TextStyle(color: Colors.black54))
      ],
    );
  }

  value1row() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(date,style: TextStyle(color: Colors.black,fontSize: 16.0),),
        Text(time,style: TextStyle(color: Colors.black,fontSize: 16.0))
      ],
    );
  }

  headingrow2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Hospital",style: TextStyle(color: Colors.black54)),
        Text("Type",style: TextStyle(color: Colors.black54)),
        //Text("APPOINTMENT ID",style: TextStyle(color: Colors.black54),),

      ],
    );
  }

  value2row() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(hospitalName,style: TextStyle(color: Colors.black,fontSize: 16.0)),
        Text(consultType,style: TextStyle(color: Colors.black,fontSize: 16.0)),
        //Text("50355104",style: TextStyle(color: Colors.black,fontSize: 16.0),),
      ],
    );
  }

  doctorDetailsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("To",style: TextStyle(color: Colors.black54)),
            SizedBox(height: 8,),
            Text(consultantName,style: TextStyle(color: Colors.black,fontSize: 16.0)),
            SizedBox(height: 8,),
            Text((specialityName),style: TextStyle(color: Colors.black54)),

          ],
        ),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black54),
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage(imageUrl), fit: BoxFit.cover)),
        )
      ],
    );
  }

  /*descriptionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Description",style: TextStyle(color: Colors.black54)),
            SizedBox(height: 8,),
            Text(description,style: TextStyle(color: Colors.black,fontSize: 16.0)),
          ],
        ),
        *//*Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Type",style: TextStyle(color: Colors.black54)),
            SizedBox(height: 8,),
            Text(consultType,style: TextStyle(color: Colors.black,fontSize: 16.0)),
          ],
        ),*//*

      ],
    );
  }*/

}
