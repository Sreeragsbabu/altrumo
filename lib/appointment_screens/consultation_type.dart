import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'speciality.dart';
class ConsultationType extends StatefulWidget {
  final String pName;
  final String uhid;

  const ConsultationType({Key key, this.pName, this.uhid}) : super(key: key);
  @override
  _ConsultationTypeState createState() => _ConsultationTypeState();
}

class _ConsultationTypeState extends State<ConsultationType> {
  String consulatType ="";
  List<ConsultType> typesofConsultation = [
    ConsultType("Phone", "assets/phone_doc.png"),
    ConsultType("Video", "assets/video_doc.png"),
    ConsultType("Physical Visit", "assets/book_doc.png"),
  ];
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Consultation Type"),
        ),
        //bottomNavigationBar: nextButton(),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text("Patient Name :", style: TextStyle(fontSize: 16.0),)),
                          Flexible(
                            child: Container(
                                padding: EdgeInsets.only(left: 16.0),
                                child:  Text(

                                  widget.pName,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                )
                            ),
                          )
                        ],
                      ),

                      Divider(color: Colors.grey,),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text("UHID : ", style: TextStyle(fontSize: 16.0),)),
                          Flexible(
                            child: Container(
                                padding: EdgeInsets.only(left: 16.0),
                                child:  Text(

                                  widget.uhid,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                )
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0,),
              Align(alignment: Alignment.center,child: Text("Select the type of consultation ",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)),
              SizedBox(height: 16.0,),
              Container(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: typesofConsultation.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex=index;
                          consulatType  = typesofConsultation[index].name;
                          print(typesofConsultation[index].name);
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorSpeciality(
                          pName: widget.pName,
                          uhid: widget.uhid,
                          conType: consulatType,)));
                      },
                      child: Container(
                        //padding: EdgeInsets.all(10.0),
                        width: 120,
                        child: Card( 
                          shape: (selectedIndex==index)
                              ? RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              side: BorderSide(color: Colors.blue,width: 4.0))
                              :  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)
                      ),
                          elevation: 10,
                          child: Container(
                            //padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(typesofConsultation[index].url),
                                  radius: 24.0,
                                ),
                                SizedBox(height: 10,),
                                Flexible(child: Text(typesofConsultation[index].name))
                              ],
                            ),
                          ),
                        ),
                      ),
                    );

                  },
                ),
              ),

             /* Container(
                child: ListView.builder(
                  //scrollDirection: Axis.horizontal,
                  itemCount: typesofConsultation.length,
                  itemBuilder: (BuildContext context, int position) {
                    return InkWell(
                      onTap: () => setState(() => selectedIndex=position),
                      child: Container(
                        width: 150,
                        child: Card(
                          shape: (selectedIndex==position)
                              ? RoundedRectangleBorder(
                              side: BorderSide(color: Colors.green))
                              : null,
                          elevation: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(typesofConsultation[position].name)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }

  /*nextButton() {
    return GestureDetector(
      onTap: () {
        if(selectedIndex == -1){
          Fluttertoast.showToast(msg: "Please select which consultation type you want.");
        }
        else{
          print(consulatType);
          Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorSpeciality(
            pName: widget.pName,
            uhid: widget.uhid,
          conType: consulatType,)));
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
  }*/
}


class ConsultType{
  final String name;
  final String url;

  ConsultType(this.name, this.url);

}
