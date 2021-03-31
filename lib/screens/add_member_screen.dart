import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddMemberScreen extends StatefulWidget {
  final Function addMembers;
AddMemberScreen(this.addMembers);
  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

enum Genders { Male, Female }
class _AddMemberScreenState extends State<AddMemberScreen> {

  TextEditingController nameController = TextEditingController();

  DateTime date = DateTime.now();
  var convertedDate = DateFormat.yMMMd().format(DateTime.now());
  //String day;
 // String month;
  String year;
  int age = 0;

  Future<void> selectTimePicker(BuildContext context) async{
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if(pickedDate != null && pickedDate != date){
      // day= DateFormat.d().format(date);
      // month= DateFormat.m().format(date);

      setState(() {
        date=pickedDate;
        convertedDate = DateFormat.yMMMd().format(date);
      }
      );
      year = DateFormat.y().format(date);
      calculateAge(year);
    }
  }

  Genders selectedGender = Genders.Male;
  NumberPicker horizontalNumberPicker;
  int selectedWeight = 50;
  String bloodGroupSelected = "";
  String relationSelected = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Member"),
      ),
      floatingActionButton: Tooltip(
        message: "Save",
        child: FloatingActionButton(
          onPressed: (){
            if(nameController.text.isNotEmpty && relationSelected.isNotEmpty && age > 0){
              Navigator.pop(context);
              Fluttertoast.showToast(msg: 'Saved');
              widget.addMembers(nameController.text, age.toString(), convertedDate.toString(),
                  selectedGender.toString().substring(selectedGender.toString().indexOf('.') + 1), relationSelected);
            }
            else{
              Fluttertoast.showToast(msg: "Please enter name, age and relation of new member");
            }

          },
          child: Icon(Icons.save),
          mini: true,
        ),
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
                SizedBox(width: 24.0,),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Name"
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.contact_phone_sharp),
                            hintText: "Mobile Number"
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
          SizedBox(height: 10.0,),
          Column(
            children: [
              GestureDetector(
                onTap: (){
                  selectTimePicker(context);
                },
                child: Card(
                  child: Container(
                    padding:EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Date of Birth"),
                        Text(convertedDate,style: TextStyle(color: Colors.blue),)
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
                    padding:EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Gender"),
                        Text(selectedGender.toString().substring(selectedGender.toString().indexOf('.') + 1),style: TextStyle(color: Colors.blue),)
                      ],
                    ),
                  ),
                ),
              ),
              // GestureDetector(
              //   onTap: (){
              //     showDialog(
              //         context: context,
              //         builder: (context) {
              //           return NumberPickerDialog.integer(
              //             minValue: 10, maxValue: 100,
              //             initialIntegerValue: 34,
              //             title: Text("Select your weight"),);
              //         }
              //     ).then((value) {
              //       if(value != null){
              //         setState(() {
              //           selectedWeight = value;
              //         });
              //       }
              //     });
              //   },
              //   child: Card(
              //     child: Container(
              //       padding:EdgeInsets.all(16.0),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text("Weight"),
              //           Text(selectedWeight.toString()+" Kg",style: TextStyle(color: Colors.blue),)
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              GestureDetector(
                 onTap: (){
                  Fluttertoast.showToast(msg: "Cant edit your age.");
                 },
                child: Card(
                  child: Container(
                    padding:EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Age"),
                        Text(age.toString(), style: TextStyle(color: Colors.blue),)
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: GestureDetector(
                  onTap: (){
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 10.0,),
                              Text("Select your blood group",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18.0),),
                              SizedBox(height: 10.0,),
                              Divider(color: Colors.grey,),
                              Wrap(
                                spacing: 10.0,
                                runSpacing: 10.0,
                                children: [
                                  choiceChipBloodGroup(chipLabel: "A+",),
                                  choiceChipBloodGroup(chipLabel: "A-",),
                                  choiceChipBloodGroup(chipLabel: "B+",),
                                  choiceChipBloodGroup(chipLabel: "B-",),
                                  choiceChipBloodGroup(chipLabel: "0+",),
                                  choiceChipBloodGroup(chipLabel: "0-",),
                                  choiceChipBloodGroup(chipLabel: "AB+",),
                                  choiceChipBloodGroup(chipLabel: "AB-",)

                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Wrap(
                                    spacing: 10.0,
                                    runSpacing: 10.0,
                                    children: [

                                    ],
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
                      padding:EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Blood Group"),
                          Text(bloodGroupSelected,style: TextStyle(color: Colors.blue),)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 10.0,),
                            Text("Select your relation with this member",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18.0),),
                            SizedBox(height: 10.0,),
                            Divider(color: Colors.grey,),
                            Wrap(
                              spacing: 10.0,
                              children: [
                                choiceChipRelation(chipLabel: "Father",),
                                choiceChipRelation(chipLabel: "Mother",),
                                choiceChipRelation(chipLabel: "Sister",),
                                choiceChipRelation(chipLabel: "Brother",),
                                choiceChipRelation(chipLabel: "Wife",),
                                choiceChipRelation(chipLabel: "Husband",),
                                choiceChipRelation(chipLabel: "Son",),
                                choiceChipRelation(chipLabel: "Daughter",),
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
                    padding:EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Relation"),
                        Text(relationSelected,style: TextStyle(color: Colors.blue),)
                      ],
                    ),
                  ),
                ),
              ),
              // Card(
              //   child: Container(
              //     padding:EdgeInsets.all(16.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text("Emergency Contact"),
              //         Text("")
              //       ],
              //     ),
              //   ),
              // )
            ],
          )
        ],
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
      onSelected: (value){
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
      onSelected: (value){
        Navigator.pop(context);
        setState(() {
          relationSelected = chipLabel;
        });
      },
    );
  }
}








