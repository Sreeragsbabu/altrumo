import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'hospital_location_screen.dart';
import 'home.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoggedIn =false;
  String _name;
  Map data;

   /*addData(String name) {
    Map<String, dynamic> demoData = {'name' : name};
    CollectionReference collectionReference = Firestore.instance.collection('patient_data');
    collectionReference.add(demoData);
  }*/

  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String name;
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          bottomNavigationBar: nextButton(),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24, left: 24),
                  child: Text(
                    "Profile Info",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Divider(
                  height: 1.5,
                  thickness: 2.0,
                ),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfilePhoto(),
                      SizedBox(
                        width: 24,
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextField(
                                decoration: InputDecoration(hintText: "First name"),
                                controller: nameController,
                              ),
                              TextField(
                                decoration: InputDecoration(hintText: "Last name"),
                              ),
                              TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(

                                    hintText: "Age"),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Do you really want to exit the app"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text("No")),
                FlatButton(onPressed: (){
                  Navigator.pop(context, true);
                }, child: Text("Yes"))
              ],
            ));
  }

  nextButton() {
    return GestureDetector(
      onTap: () async{
        try{
          if(nameController.text.isNotEmpty)
          {
            if( nameController.text == "guest" || nameController.text == 'Guest'){
              Fluttertoast.showToast(msg: "Please enter a different name");
            }
            else{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('isLoggedIn', true);
              prefs.setString('displayName', nameController.text.toString());
              Navigator.push(context, MaterialPageRoute(builder: (context) => HospiatlLocationScreen()));
            }
            //addData(nameController.text.toString());

            /*Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
                    (Route<dynamic> route) => false
            );*/

            // Navigator.of(context)
            //     .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);

            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(builder: (context) => HomeScreen()),
            //     ModalRoute.withName("/home"));
          }
          else{
            Fluttertoast.showToast(msg: "Please enter your name");
          }
        }
        catch(exception){
          //Fluttertoast.showToast(msg: "Enter all the required details");
          print(exception);
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 48,
        width: MediaQuery.of(context).size.width,
        color: Color(0xff1976d2),
        child: Text(
          "Next",
          style: TextStyle(color: Colors.white, fontSize: 14.0),
        ),
      ),
    );
  }


}

class ProfilePhoto extends StatefulWidget {
  @override
  _ProfilePhotoState createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _ProfilePhotoSelect();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0, top: 24),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black54),
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage("assets/pro_pic.png"), fit: BoxFit.cover)),
        ),
      ),
    );
  }

  void _ProfilePhotoSelect() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xff737373),
            child: Container(
              child: bottomNavigationProfile(),
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
            ),
          );
        });
  }

  Column bottomNavigationProfile() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: () {},
          leading: Icon(Icons.camera_alt),
          title: Text("Camera"),
        ),
        ListTile(
          leading: Icon(Icons.image),
          title: Text("Gallery"),
        ),
        ListTile(
          leading: Icon(Icons.delete),
          title: Text("Delete"),
        ),
      ],
    );
  }
}

