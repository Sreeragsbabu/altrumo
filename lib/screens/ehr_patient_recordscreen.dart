import 'package:flutter/material.dart';

class EhrPatientRecordScreen extends StatefulWidget {

  @override
  _EhrPatientRecordScreenState createState() => _EhrPatientRecordScreenState();
}

class _EhrPatientRecordScreenState extends State<EhrPatientRecordScreen> {
  TextEditingController tempController = TextEditingController();

  TextEditingController weightController = TextEditingController();

  TextEditingController heightController = TextEditingController();

  TextEditingController bloodGroupController = TextEditingController();

  TextEditingController bloodPressureController = TextEditingController();

  TextEditingController pulseController = TextEditingController();

  int temp = 37;
  int pulse = 0;
  int weight = 0;
  int height = 0;
  double heightInch = 0.0;
  double bmi = 0.0;
  double heightMeter;
  String bloodGroup ="";
  String bloodPressure = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Container(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(10.0),
                title: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sreeragaaa",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.blue),),
                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Text("Temperature :",style: TextStyle(fontSize: 14.0),),
                          Text(temp.toString() + " °C",style: TextStyle(fontSize: 14.0),),
                          Spacer(),
                          GestureDetector(
                              onTap: (){
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: true,
                                  // false = user must tap button, true = tap outside dialog
                                  builder: (BuildContext dialogContext) {
                                    return AlertDialog(
                                      title: Text('Enter Temperature'),
                                      content: TextField(
                                        controller: tempController,
                                        decoration: InputDecoration(
                                          hintText: "enter"
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('save'),
                                          onPressed: () {
                                            setState(() {
                                              temp = int.parse(tempController.text);
                                            });
                                            Navigator.of(dialogContext)
                                                .pop(); // Dismiss alert dialog
                                          },
                                        ),
                                        FlatButton(
                                          child: Text('cancel'),
                                          onPressed: () {
                                            Navigator.of(dialogContext)
                                                .pop(); // Dismiss alert dialog
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Icon(Icons.edit,size: 16.0,))
                        ],
                      ),
                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Text("Weight :",style: TextStyle(fontSize: 14.0),),
                          Text( weight.toString() + " Kg",style: TextStyle(fontSize: 14.0),),
                          Spacer(),
                          GestureDetector(
                              onTap: (){
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: true,
                                  // false = user must tap button, true = tap outside dialog
                                  builder: (BuildContext dialogContext) {
                                    return AlertDialog(
                                      title: Text('Enter Weight'),
                                      content: TextField(
                                        controller: weightController,
                                        decoration: InputDecoration(
                                            hintText: "enter"
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('save'),
                                          onPressed: () {
                                            setState(() {
                                              weight = int.parse(weightController.text);
                                              //bmi = weight / (heightMeter * heightMeter);
                                            });
                                            Navigator.of(dialogContext)
                                                .pop(); // Dismiss alert dialog
                                          },
                                        ),
                                        FlatButton(
                                          child: Text('cancel'),
                                          onPressed: () {
                                            Navigator.of(dialogContext)
                                                .pop(); // Dismiss alert dialog
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Icon(Icons.edit,size: 16.0,))
                        ],
                      ),
                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Text("Height :",style: TextStyle(fontSize: 14.0),),
                          Text( height.toString()+" cm",style: TextStyle(fontSize: 14.0),),
                          Text( "  ("+ heightInch.toString()+" inches)",style: TextStyle(fontSize: 14.0),),
                          Spacer(),
                          GestureDetector(
                              onTap: (){
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: true,
                                  // false = user must tap button, true = tap outside dialog
                                  builder: (BuildContext dialogContext) {
                                    return AlertDialog(
                                      title: Text('Enter Height'),
                                      content: TextField(
                                        controller: heightController,
                                        decoration: InputDecoration(
                                            hintText: "enter"
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('save'),
                                          onPressed: () {
                                            setState(() {
                                              height = int.parse(heightController.text);
                                              heightInch =double.parse(( height * 0.393701).toStringAsFixed(2));
                                              heightMeter = height/100;
                                              bmi = weight / (heightMeter * heightMeter);
                                            });
                                            Navigator.of(dialogContext)
                                                .pop(); // Dismiss alert dialog
                                          },
                                        ),
                                        FlatButton(
                                          child: Text('cancel'),
                                          onPressed: () {
                                            Navigator.of(dialogContext)
                                                .pop(); // Dismiss alert dialog
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Icon(Icons.edit,size: 16.0,))
                        ],
                      ),
                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Text("BMI :",style: TextStyle(fontSize: 14.0),),
                          Text(bmi.toStringAsFixed(1),style: TextStyle(fontSize: 14.0),),
                        ],
                      ),
                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Text("Blood Group :",style: TextStyle(fontSize: 14.0),),
                          Text(bloodGroup,style: TextStyle(fontSize: 14.0),),
                          Spacer(),
                          GestureDetector(
                              onTap: (){
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: true,
                                  // false = user must tap button, true = tap outside dialog
                                  builder: (BuildContext dialogContext) {
                                    return AlertDialog(
                                      title: Text('Enter Blood Group'),
                                      content: TextField(
                                        controller: bloodGroupController,
                                        decoration: InputDecoration(
                                            hintText: "enter"
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('save'),
                                          onPressed: () {
                                            setState(() {
                                              bloodGroup = bloodGroupController.text;
                                            });
                                            Navigator.of(dialogContext)
                                                .pop(); // Dismiss alert dialog
                                          },
                                        ),
                                        FlatButton(
                                          child: Text('cancel'),
                                          onPressed: () {
                                            Navigator.of(dialogContext)
                                                .pop(); // Dismiss alert dialog
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Icon(Icons.edit,size: 16.0,))
                        ],
                      ),
                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Text("Blood Pressure :",style: TextStyle(fontSize: 14.0),),
                          Text(bloodPressure,style: TextStyle(fontSize: 14.0),),
                          Spacer(),
                          GestureDetector(
                              onTap: (){
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: true,
                                  // false = user must tap button, true = tap outside dialog
                                  builder: (BuildContext dialogContext) {
                                    return AlertDialog(
                                      title: Text('Enter Blood Pressure'),
                                      content: TextField(
                                        controller: bloodPressureController,
                                        decoration: InputDecoration(
                                            hintText: "enter"
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('save'),
                                          onPressed: () {
                                            setState(() {
                                              bloodPressure = bloodPressureController.text;
                                            });
                                            Navigator.of(dialogContext)
                                                .pop(); // Dismiss alert dialog
                                          },
                                        ),
                                        FlatButton(
                                          child: Text('cancel'),
                                          onPressed: () {
                                            Navigator.of(dialogContext)
                                                .pop(); // Dismiss alert dialog
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Icon(Icons.edit,size: 16.0,))
                        ],
                      ),
                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Text("Pulse :",style: TextStyle(fontSize: 14.0),),
                          Text(pulse.toString() + "  BPM",style: TextStyle(fontSize: 14.0),),
                          Spacer(),
                          GestureDetector(
                              onTap: (){
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: true,
                                  // false = user must tap button, true = tap outside dialog
                                  builder: (BuildContext dialogContext) {
                                    return AlertDialog(
                                      title: Text('Enter Pulse'),
                                      content: TextField(
                                        controller: pulseController,
                                        decoration: InputDecoration(
                                            hintText: "enter"
                                        ),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('save'),
                                          onPressed: () {
                                            setState(() {
                                              pulse = int.parse(pulseController.text);
                                            });
                                            Navigator.of(dialogContext)
                                                .pop(); // Dismiss alert dialog
                                          },
                                        ),
                                        FlatButton(
                                          child: Text('cancel'),
                                          onPressed: () {
                                            Navigator.of(dialogContext)
                                                .pop(); // Dismiss alert dialog
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Icon(Icons.edit,size: 16.0,))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
