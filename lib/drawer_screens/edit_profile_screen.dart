import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

enum Genders { Male, Female }
enum Status { Married, Single }

class _EditProfileScreenState extends State<EditProfileScreen> {
  DateTime date = DateTime.now();
  var convertedDate = DateFormat.yMMMd().format(DateTime.now());
  //String day;
  // String month;
  String year;
  int age = 0;

  Future<void> selectTimePicker(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != date) {
      // day= DateFormat.d().format(date);
      // month= DateFormat.m().format(date);

      setState(() {
        date = pickedDate;
        convertedDate = DateFormat.yMMMd().format(date);
      });
      year = DateFormat.y().format(date);
      calculateAge(year);
    }
  }

  Genders selectedGender = Genders.Male;
  Status maritalStatus = Status.Single;
  NumberPicker horizontalNumberPicker;
  int selectedWeight = 50;
  int selectedHeight = 5;

  String bloodGroupSelected = "";
  String relationSelected = "";
  String email = "";
  TextEditingController emailController = TextEditingController();
  String emergencyContactName="";
  String emergencyContactNumber = "";
  TextEditingController emergencyNameController = TextEditingController();
  TextEditingController emergencyNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
          actions: [
            IconButton(onPressed: (){
              Fluttertoast.showToast(msg: "Saved");
              Navigator.pop(context);
            },
              icon: Icon(Icons.save,color: Colors.white,),)
          ],
        ),
        body: ListView(
          children: [
            Card(
              child: Container(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/pro_pic.png"),
                      radius: 36.0,
                    ),
                    SizedBox(
                      width: 24.0,
                    ),
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: InputDecoration(hintText: "Name"),
                          ),
                          TextField(
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.contact_phone_sharp),
                                hintText: "Mobile Number"),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: true,
                      // false = user must tap button, true = tap outside dialog
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          title: Text('Enter Email ID'),
                          content: TextField(
                            controller: emailController,
                            decoration: InputDecoration(hintText: "Email ID"),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(dialogContext)
                                    .pop(); // Dismiss alert dialog
                              },
                            ),
                            FlatButton(
                              child: Text('Save'),
                              onPressed: () {
                                setState(() {
                                  email = emailController.text;
                                });
                                Navigator.of(dialogContext)
                                    .pop();
                                // Dismiss alert dialog
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Email ID"),
                          Text(
                            email,
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: true,
                      // false = user must tap button, true = tap outside dialog
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          title: Text('Select a Gender'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: const Text('Male'),
                                leading: Radio(
                                  value: Genders.Male,
                                  groupValue: selectedGender,
                                  onChanged: (Genders value) {
                                    Navigator.pop(context);
                                    setState(() {
                                      selectedGender = value;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('Female'),
                                leading: Radio(
                                  value: Genders.Female,
                                  groupValue: selectedGender,
                                  onChanged: (Genders value) {
                                    Navigator.pop(context);
                                    setState(() {
                                      selectedGender = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Cancel'),
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
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Gender"),
                          Text(
                            selectedGender.toString().substring(
                                selectedGender.toString().indexOf('.') + 1),
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectTimePicker(context);
                  },
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Date of Birth"),
                          Text(
                            convertedDate,
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(msg: "Cant edit your age.");
                  },
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Age"),
                          Text(
                            age.toString(),
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Select your blood group",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.0),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                Wrap(
                                  spacing: 10.0,
                                  runSpacing: 10.0,
                                  children: [
                                    choiceChipBloodGroup(
                                      chipLabel: "A+",
                                    ),
                                    choiceChipBloodGroup(
                                      chipLabel: "A-",
                                    ),
                                    choiceChipBloodGroup(
                                      chipLabel: "B+",
                                    ),
                                    choiceChipBloodGroup(
                                      chipLabel: "B-",
                                    ),
                                    choiceChipBloodGroup(
                                      chipLabel: "0+",
                                    ),
                                    choiceChipBloodGroup(
                                      chipLabel: "0-",
                                    ),
                                    choiceChipBloodGroup(
                                      chipLabel: "AB+",
                                    ),
                                    choiceChipBloodGroup(
                                      chipLabel: "AB-",
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Wrap(
                                      spacing: 10.0,
                                      runSpacing: 10.0,
                                      children: [],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Blood Group"),
                            Text(
                              bloodGroupSelected,
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     showDialog(
                //         context: context,
                //         builder: (context) {
                //           return NumberPickerDialog.integer(
                //             minValue: 1,
                //             maxValue: 10,
                //             initialIntegerValue: 1,
                //             title: Text("Select your height"),
                //           );
                //         }).then((value) {
                //       if (value != null) {
                //         setState(() {
                //           selectedHeight = value;
                //         });
                //       }
                //     });
                //   },
                //   child: Card(
                //     child: Container(
                //       padding: EdgeInsets.all(16.0),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text("Height"),
                //           Text(
                //             selectedHeight.toString() + "feet",
                //             style: TextStyle(color: Colors.blue),
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return NumberPickerDialog.integer(
                            minValue: 1,
                            maxValue: 100,
                            initialIntegerValue: 50,
                            title: Text("Select your weight"),
                          );
                        }).then((value) {
                      if (value != null) {
                        setState(() {
                          selectedWeight = value;
                        });
                      }
                    });
                  },
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Weight"),
                          Text(
                            selectedWeight.toString() + " Kg",
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: true,
                      // false = user must tap button, true = tap outside dialog
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          title: Text('Marital Status'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: const Text('Married'),
                                leading: Radio(
                                  value: Status.Married,
                                  groupValue: maritalStatus,
                                  onChanged: (Status value) {
                                    Navigator.pop(context);
                                    setState(() {
                                      maritalStatus = value;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: const Text('Single'),
                                leading: Radio(
                                  value: Status.Single,
                                  groupValue: maritalStatus,
                                  onChanged: (Status value) {
                                    Navigator.pop(context);
                                    setState(() {
                                      maritalStatus = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Cancel'),
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
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Marital Status"),
                          Text(
                            maritalStatus.toString().substring(
                                maritalStatus.toString().indexOf('.') + 1),
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    showDialog<void>(
                      context: context,
                      barrierDismissible: true,
                      // false = user must tap button, true = tap outside dialog
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          title: Text('Emergency Contact'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: emergencyNameController,
                                decoration: InputDecoration(
                                  hintText: "Name"
                                ),
                              ),
                              TextField(
                                controller: emergencyNumberController,
                                decoration: InputDecoration(
                                  hintText: "Enter the number"
                                ),
                              ),
                            ],

                          ),
                          actions: <Widget>[

                            FlatButton(

                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(dialogContext)
                                    .pop(); // Dismiss alert dialog
                              },
                            ),
                            FlatButton(
                              child: Text('Save'),
                              onPressed: () {
                                setState(() {
                                  emergencyContactName = emergencyNameController.text;
                                  emergencyContactNumber = emergencyNumberController.text;
                                });
                                Navigator.of(dialogContext)
                                    .pop(); // Dismiss alert dialog
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Card(
                    child: Container(
                      padding:EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Emergency Contact"),
                          Column(
                            children: [
                              Text(emergencyContactName),
                              Text(emergencyContactNumber)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  int calculateAge(String year) {
    DateTime currentDate = DateTime.now();
    age = currentDate.year - int.parse(year);
    return age;
  }

  choiceChipBloodGroup({String chipLabel}) {
    return ChoiceChip(
      label: Text(chipLabel),
      labelStyle: TextStyle(color: Colors.white),
      backgroundColor: Colors.blue,
      selected: false,
      selectedColor: Colors.orange,
      onSelected: (value) {
        Navigator.pop(context);
        setState(() {
          bloodGroupSelected = chipLabel;
        });
      },
    );
  }

  choiceChipRelation({String chipLabel}) {
    return ChoiceChip(
      label: Text(chipLabel),
      labelStyle: TextStyle(color: Colors.white),
      backgroundColor: Colors.blue,
      selected: false,
      selectedColor: Colors.orange,
      onSelected: (value) {
        Navigator.pop(context);
        setState(() {
          relationSelected = chipLabel;
        });
      },
    );
  }

}
