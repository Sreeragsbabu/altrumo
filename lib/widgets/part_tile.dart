import 'package:flutter/material.dart';
import 'package:demo_altrumo/screens/package_details.dart';

class PartTile extends StatelessWidget {
  final String title;
  final double price;
  final int index;
  final ValueChanged<int> onAdd;

  PartTile(
      {Key key,
      //this.gender,
      this.title,
      //this.subTitle,
      //this.url,
      this.price,
      this.index,
      this.onAdd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 10.0,
        ),
        child: Stack(
          children: <Widget>[
            deviceCard(context),
          ],
        ));
  }

  Widget deviceCard(BuildContext context) {
    /*return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Row(
          children: [
            Flexible(
              child: Column(
                children: [
                  Text("Package Name : $title"),
                  SizedBox(height: 8.0,),
                  //Text("Package Name : $price"),
                ],
              ),
            )
          ],
        ),
      ),
    );*/
    return Card(
      child: ListTile(
        onTap: (){
          //Navigator.push(context, MaterialPageRoute(builder: (context) => PackageDetailsScreen(pacName: title)));
        },
        leading:  CircleAvatar(
          child: Text(title.substring(0,1)),
        ),
        title: Text(title == null ? '' : title,),
        subtitle: Text("₹ " + price.toString(),),
       // subtitle: Text(subTitle == null ? '' : subTitle,),
        trailing: Container(
          decoration: BoxDecoration(
              color: Color(0xff1976d2),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            shape: BoxShape.rectangle
          ),

          padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 6.0),
          child: Text("Book",style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }



}
