import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Contact Us"),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.0,),
            Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                        image: AssetImage("assets/altrumo.png"),
                        fit: BoxFit.fitHeight))),
            Text("Altrumo", style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
            SizedBox(height: 20.0,),
            Card(
              child: ExpansionTile(
                leading: Icon(Icons.link),
                title: Text("Website"),
                children: [
                  Text("webpage url comes here")
                ],
              ),
            ),
            Card(
              child: ExpansionTile(
                children: [
                  Text("contact details")
                ],
                leading: Icon(Icons.phone),
                title: Text("Phone Number"),
              ),
            ),
            Card(
              child: ExpansionTile(
                children: [
                  Text("Email Id")
                ],
                leading: Icon(Icons.email),
                title: Text("Email ID"),
              ),
            ),
            Card(
              child: ExpansionTile(
                children: [
                  Text("Twitter Account Details")
                ],
                leading: Icon(Icons.email),
                title: Text("Twitter"),
              ),
            ),
          ],
          )
        ),
      ),
    );
  }
}
