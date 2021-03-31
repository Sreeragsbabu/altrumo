import 'package:demo_altrumo/alert_dialogs/guest_login_alert.dart';
import 'package:demo_altrumo/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:demo_altrumo/screens/add_member_screen.dart';
import 'package:demo_altrumo/models/members.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo_altrumo/screens/phone_auth_screen.dart';
import 'package:demo_altrumo/screens/login_screen.dart';

class FamilyMembersScreen extends StatefulWidget {
  @override
  _FamilyMembersScreenState createState() => _FamilyMembersScreenState();
}

class _FamilyMembersScreenState extends State<FamilyMembersScreen> {
 final List<Members> members= [
   Members(name: "Sreerag",age: "25", dob: "23 May, 1995", gender: "Male", relation: "Self")
 ];
 final List<Members> guest= [
   Members(name: "Guest",age: "age", dob: "", gender: "gender", relation: "relation")
 ];
 bool isCheck = false;

 @override
 void initState() {
   checkUser();
   super.initState();
 }

 checkUser() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   var isGuest = prefs.getString('displayName');
   if(isGuest == "Guest"){
     setState(() {
       isCheck = true;
     });
   }
 }

 void _addNewMember(String name, String age, String dob, String gender, String relation){
   final newMembers = Members(name: name, age: age, dob: dob, gender: gender, relation: relation);
   setState(() {
     members.add(newMembers);
   });
 }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Manage Family Members"),
        ),
        body: isCheck? Container(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [

            Column(
                children:guest.map((myMembers) {
              return Card(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10.0),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/pro_pic.png"),
                    radius: 24.0,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(myMembers.name,style: TextStyle(fontWeight: FontWeight.w500),),
                        Divider(color: Colors.grey,),
                        Text(myMembers.relation + " | " + myMembers.gender + " | " + myMembers.age, style: TextStyle(color: Colors.blue, fontSize: 14.0),),
                        Divider(color: Colors.grey,),
                        Text("UHID :  NWH007005-5",style: TextStyle(fontSize: 14.0),),
                        Divider(color: Colors.grey,),
                        Text("DOB :   " + myMembers.dob,style: TextStyle(fontSize: 14.0),)
                      ],
                    ),
                  ),
                ),
              );
              }).toList(),
            ),

                SizedBox(height: 10,),
                GestureDetector(
                  onTap: () async{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    var isGuest = prefs.getString('displayName');
                    if(isGuest =="Guest"){
                      showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        // false = user must tap button, true = tap outside dialog
                        builder: (BuildContext dialogContext) {
                          return GuestLoginAlert();
                        },
                      );
                    }
                    else{
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddMemberScreen(_addNewMember)));
                    }

                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 50.0),
                    decoration: BoxDecoration(
                        color: Color(0xff1976d2),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Text("Add New Profile",style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
        ):
        Container(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [

                Column(
                  children:members.map((myMembers) {
                    return Card(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10.0),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("assets/pro_pic.png"),
                          radius: 24.0,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(myMembers.name,style: TextStyle(fontWeight: FontWeight.w500),),
                              Divider(color: Colors.grey,),
                              Text(myMembers.relation + " | " + myMembers.gender + " | " + myMembers.age, style: TextStyle(color: Colors.blue, fontSize: 14.0),),
                              Divider(color: Colors.grey,),
                              Text("UHID :  NWH007005-5",style: TextStyle(fontSize: 14.0),),
                              Divider(color: Colors.grey,),
                              Text("DOB :   " + myMembers.dob,style: TextStyle(fontSize: 14.0),)
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddMemberScreen(_addNewMember)));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 50.0),
                    decoration: BoxDecoration(
                        color: Color(0xff1976d2),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Text("Add New Profile",style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
        )


        /*body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              *//* Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xff1976d2)),
                child: Center(
                    child: Text(
                  "Create your primary UHID by selecting any one of your own profile from below",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                )),
              ),
              SizedBox(height: 10,),*//*
              Expanded(
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
                          leading: CircleAvatar(
                            backgroundImage: AssetImage("assets/pro_pic.png"),
                            radius: 24.0,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Sreerag",style: TextStyle(fontWeight: FontWeight.w500),),
                                Divider(color: Colors.grey,),
                                Text("SELF | MALE | 25", style: TextStyle(color: Colors.blue, fontSize: 14.0),),
                                Divider(color: Colors.grey,),
                                Text("UHID :  NWH007005-5",style: TextStyle(fontSize: 14.0),),
                                Divider(color: Colors.grey,),
                                Text("DOB : 23 May, 1995",style: TextStyle(fontSize: 14.0),)
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 30.0),
              //   decoration: BoxDecoration(
              //     color: Color(0xff1976d2),
              //     borderRadius: BorderRadius.circular(10.0)
              //   ),
              //   child: Text("Link UHID",style: TextStyle(color: Colors.white),),
              // ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddMemberScreen()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 50.0),
                  decoration: BoxDecoration(
                      color: Color(0xff1976d2),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Text("Add New Profile",style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),*/
      ),
    );
  }
}
