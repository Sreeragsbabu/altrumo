import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  /* bool _isActive = false;
   int _current = 0;
   List imgList = [
     'assets/home_1.jpg',
     'assets/home_2.jpg',
     'assets/home_3.jpg',
     'assets/home_4.jpg'
   ];*/

  @override
  Widget build(BuildContext context) {
    return
      Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
           /*CarouselSlider(
               items: imgList.map((imageUrl) {
                 return Builder(builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                     decoration: BoxDecoration(),
                     child: Image.asset(
                       imageUrl,
                       fit: BoxFit.cover,
                     ),
                  );
                });
               }).toList(),
               options: CarouselOptions(
                 enlargeCenterPage: true,
                autoPlay: true,
                 autoPlayInterval: Duration(seconds: 3),
                 autoPlayAnimationDuration: Duration(milliseconds: 2000),
                 height: MediaQuery.of(context).size.height / 4,
                 initialPage: 0,
                 onPageChanged: (index, reason) {
                   setState(() {
                    _current = index;
                     _isActive = true;
                  });
                 },
               )),*/
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height /4,
            decoration: BoxDecoration(),
            child: Image.asset(
              "assets/home_2.jpg",
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 12,),
          // ExpansionTile(
          //   title: Text("Hi Sreerag,",style: TextStyle(color: Colors.black54),),
          //   trailing: Icon(Icons.add,color: Colors.white,),
          //
          //   children: [
          //
          //     ListTile(
          //       title: Text("Add Family Members",style: TextStyle(color: Colors.black54),),
          //       trailing: Icon(Icons.add),
          //       onTap: (){
          //
          //       },
          //     ),
          //   ],
          // ),
          Expanded(
            child: StaggeredGridView.count(crossAxisCount: 2,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              children: [
                InkWell(
                  onTap: (){
                    print("aaaaa");
                  },
                  child: Container(
                      child: MyItems("assets/appointment.png", "Book an Appointment", 0xffffffff)),
                ),
                MyItems("assets/ehr.png", "EHR", 0xffffffff),
                MyItems("assets/health_checkup.png", "Health Checkup",0xffffffff),
                MyItems("assets/services.png", "Find Services",0xffffffff),
                MyItems("assets/lab_reports.png", "Lab Reports", 0xffffffff),
                MyItems("assets/symptom_checker.png", "Symptom Checker", 0xffffffff),
                MyItems("assets/emergency.png", "Emergency SOS", 0xffffffff),
                MyItems("assets/doctors.png", "My Doctors", 0xffffffff),
                MyItems("assets/payment.png", "Make a Payment", 0xffffffff),

              ],
              staggeredTiles: [
                StaggeredTile.extent(1, 100.0),//appointment
                StaggeredTile.extent(1, 100.0),//ehr
                StaggeredTile.extent(1, 100.0),//healthcheckup
                StaggeredTile.extent(1, 100.0),//find services
                StaggeredTile.extent(1, 100.0),
                StaggeredTile.extent(1, 100.0),
                StaggeredTile.extent(1, 100.0),
                StaggeredTile.extent(1, 100.0),
                StaggeredTile.extent(1, 100.0)
              ],
            ),
          ),
          // Spacer(),
          // RaisedButton(
          //   textColor: Colors.white,
          //   color: Colors.blue,
          //   onPressed: () {},
          //   child: Text("Book An Appointment"),
          //   shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(16.0)),
          // ),

        ],
      ),
    );
  }

  Material MyItems(String imageUrl, String heading, int color){
    return Material(
      color: Color(color),
      elevation: 14.0,
      shadowColor: Color(0x802196f3),
      borderRadius: BorderRadius.circular(12.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Material(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Container(
                    width: 30,
                    height: 30,
                    child: Image.asset(imageUrl),
                  )
              ),
              SizedBox(width: 10,),
              Flexible(child: Text(heading,style: TextStyle(color: Colors.black54, fontSize: 14.0),)),

            ],
          ),
        ),
      ),
    );
  }
}
