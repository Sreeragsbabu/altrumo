import 'package:flutter/material.dart';

class LabReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Lab Reports"),
        ),
        body: ListView.builder(
          itemCount: 7,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                subtitle: Text("20 NOV 2020"),
                title: Text("Bill report"),
                leading: Container(
                    height: 40.0,
                    child: Image.asset("assets/pdf.png")
                ),
                trailing: Icon(Icons.more_vert_sharp),
              ),
            );
          },
        ),
      ),
    );
  }
}
