import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String docName;
  final String docCategory;
  final String docImageUrl;

  const ChatScreen({Key key, this.docName, this.docCategory, this.docImageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       body: Container(
         padding: EdgeInsets.only(bottom: 6.0),
        // height: MediaQuery.of(context).size.height,
         child: SafeArea(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Container(
                 color: Theme.of(context).primaryColor,
                 padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                 child: Row(
                   children: [
                    GestureDetector(
                        onTap:(){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back,color: Colors.white,)),
                     SizedBox(width: 10.0,),
                     CircleAvatar(
                       radius: 20.0,
                       backgroundImage: AssetImage(docImageUrl),
                     ),
                     SizedBox(width: 10.0,),
                     Container(
                         width: 140,
                         child: Text(docName,style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),)),
                     /*Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [

                         Row(
                           children: [
                             CircleAvatar(
                               radius: 5.0,
                               backgroundColor: Colors.green,
                             ),
                             SizedBox(width: 5.0,),
                             Text(docCategory,style: TextStyle(color: Colors.white),)
                           ],
                         )

                       ],
                     ),*/
                     Spacer(),
                     Icon(Icons.videocam,color: Colors.white,),
                     SizedBox(width: 20.0,),
                     Icon(Icons.phone,color: Colors.white,),
                     /*SizedBox(width: 20.0,),
                     Icon(Icons.more_vert_sharp,color: Colors.white,)*/
                   ],
                 ),

               ),
              // Spacer(),
               Container(
                 decoration: BoxDecoration(
                   color: Colors.blue.shade100,
                   borderRadius: BorderRadius.circular(30.0)
                 ),
                 padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                 child: Row(
                   children: [
                    Icon(Icons.add,size: 30.0,),
                     SizedBox(width: 10.0,),
                     Expanded(
                       child: TextField(
                         decoration: InputDecoration.collapsed(
                             border: InputBorder.none,
                           hintText: "Type a message"
                         ),
                       ),
                     ),
                     SizedBox(width: 10.0,),
                     Icon(Icons.send)
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
}
