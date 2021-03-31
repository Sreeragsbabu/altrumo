import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key key,
    @required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
     // height: 40.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: Colors.white,
        elevation: 10.0,
        child: TextField(
          cursorColor: Colors.white,
          decoration: InputDecoration(hintText: 'Search',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ))),
          controller: searchController,
        ),
      ),
    );
  }
}
