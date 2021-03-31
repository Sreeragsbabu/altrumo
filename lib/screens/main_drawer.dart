import 'package:flutter/material.dart';
import 'package:demo_altrumo/drawer_screens/my_profile_screen.dart';
import 'package:demo_altrumo/drawer_screens/family_members_screen.dart';
import 'package:demo_altrumo/drawer_screens/contact_us_screen.dart';
import 'package:demo_altrumo/screens/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo_altrumo/profile_models/patient_details.dart';
import 'package:demo_altrumo/services/login_services.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {

  bool isCheck = false;
  PatientDetails patientDetails;
  bool _loading;
  @override
  void initState() {
    checkUser();
    loadData();
    super.initState();
  }

  void loadData() async{
    _loading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenId = prefs.getString('token');
    var _uhid = prefs.getString('uhid');
    /*AllDoctorServices.getDoctors().then((upcoming) {
      setState(() {
        getPatients = upcoming;
        _loading = false;
      });

    });*/
    PatientDetailServices.getPatientDetails(tokenId, _uhid).then((value) {
      setState(() {
        patientDetails = value;
        _loading = false;
      });
    });

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
  String uhid= "NWH007005-5";
  TextEditingController uhidController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          isCheck ?
          Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profilePicture(),
                  SizedBox(
                    height: 12,
                  ),
                  Divider(color: Colors.white,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Guest",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "Gender | age",
                        style: TextStyle(color: Colors.white),
                      ),

                    ],
                  ),
                  Divider(color: Colors.white,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("UHID : ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "phone no.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ) :

          Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
            child: Container(
              width: double.infinity,
              child: _loading ? Center(child: CircularProgressIndicator()):Column(
                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profilePicture(),
                  SizedBox(
                    height: 12,
                  ),
                  Divider(color: Colors.white,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        patientDetails.firstName,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                          patientDetails.gender+ " | " + patientDetails.age.substring(0,2)+ "yrs",
                        style: TextStyle(color: Colors.white),
                      ),

                    ],
                  ),
                  Divider(color: Colors.white,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("UHID : "+patientDetails.uhid,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        patientDetails.mobileNo,
                        style: TextStyle(color: Colors.white),
                      ),


                    ],
                  ),
                ],
              ),
            ),
          ),

          Flexible(
            child: ListView(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FamilyMembersScreen()));
                  },
                  title: Text("Link UHID"),
                  leading: Icon(Icons.people_rounded),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfileScreen()));
                  },
                  title: Text("Profile"),
                  leading: Icon(Icons.person_rounded),
                ),
                ListTile(
                  onTap: () {},
                  title: Text("Feeds"),
                  leading: Icon(Icons.rss_feed_sharp),
                ),
                ListTile(
                  onTap: () {},
                  title: Text("Directions"),
                  leading: Icon(Icons.directions),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsScreen()));
                  },
                  title: Text("Contact Us"),
                  leading: Icon(Icons.call_outlined),
                ),
                ListTile(
                  onTap: () {},
                  title: Text("Share With Friends"),
                  leading: Icon(Icons.share),
                ),
                ListTile(
                  onTap: () {},
                  title: Text("Rate This App"),
                  leading: Icon(Icons.thumb_up),
                ),
                ListTile(
                  onTap: () {},
                  title: Text("Follow Us on Facebook" ),
                  leading: Icon(Icons.favorite),
                ),
                ListTile(
                  onTap: () {},
                  title: Text("About Us" ),
                  leading: Icon(Icons.supervisor_account),
                ),
                ListTile(
                  onTap: () {},
                  title: Text("FAQ" ),
                  leading: Icon(Icons.perm_identity_sharp),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
                  },
                  title: Text("Settings" ),
                  leading: Icon(Icons.settings),
                ),
              ],
            ),
          )

                ],
      ),
    );
  }

  profilePicture() {
    return CircleAvatar(
      radius: 50.0,
      backgroundImage: AssetImage("assets/pro_pic.png"),
    );
  }
}
