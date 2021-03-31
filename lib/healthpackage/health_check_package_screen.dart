import 'package:flutter/material.dart';
import 'package:demo_altrumo/screens/package_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo_altrumo/screens/hospital_location_screen.dart';
import 'package:demo_altrumo/models/packages.dart';

import 'package:demo_altrumo/healthpackage/package_state.dart';
import 'package:demo_altrumo/healthpackage/package_filter.dart';
import 'package:demo_altrumo/widgets/part_tile.dart';
import 'package:demo_altrumo/widgets/search_field.dart';
import 'package:demo_altrumo/package_models/packages.dart';

class HealthCheckPackageScreen extends StatefulWidget {
  final String hospitalName,hospitalLocation;


  const HealthCheckPackageScreen({Key key, this.hospitalName, this.hospitalLocation}) : super(key: key);
  @override
  _HealthCheckPackageScreenState createState() => _HealthCheckPackageScreenState();
}


class _HealthCheckPackageScreenState extends State<HealthCheckPackageScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  bool showSearch;

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(searchListener);
    packageState.loadData();
    showSearch = packageState.searchEnable;
    searchController.text = packageState.searchString;
  }

  showMessage(String txt) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(txt),
      duration: Duration(seconds: 1),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
        appBar: AppBar(
          title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.hospitalName, style: TextStyle(fontSize: 16.0),),
              Text("packages", style: TextStyle(fontSize: 14.0),),
            ],
          ),
          /*title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [

              Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                          image: AssetImage("assets/pro_pic.png"),
                          fit: BoxFit.fitHeight))),
              SizedBox(width: 8.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.hospitalName, style: TextStyle(fontSize: 16.0),),
                  GestureDetector(
                    onTap: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => HospiatlLocationScreen()));
                    },
                    child: Row(
                      children: [
                        Text(widget.hospitalLocation, style: TextStyle(fontSize: 14.0),),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),*/
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () {
                toggleSearch();
              },
            ),
            /*IconButton(
          icon: Icon(
            Icons.tune,
          ),
          tooltip: 'Filter',
          onPressed: () {
            navigate2filterPage(context);
          },
        ),*/
            PopupMenuButton(
              onSelected: (v) => packageState.sort(v),
              icon: Icon(Icons.sort),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text('Latest'),
                    value: PartSort.latest,
                  ),
                  PopupMenuItem(
                    child: Text('Low price'),
                    value: PartSort.lowPrice,
                  ),
                  PopupMenuItem(
                    child: Text('High price'),
                    value: PartSort.highPrice,
                  ),
                ];
              },
            ),
          ],

        ),
          floatingActionButton: FloatingActionButton.extended(
            label: Text("Filter"),
            onPressed: (){
              navigate2filterPage(context);
            },
            icon: Icon(Icons.filter_alt_sharp),
          ),
        /*floatingActionButton: FloatingActionButton.extended(
          label: Text("Filter"),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> PackageFilterScreen()));
          },
          icon: Icon(Icons.filter_list_alt),
        ),*/
      body: Container(
          //decoration: MyBackgroundDecoration2(),
          child: bodyBuilder(),
    ),
      ),
    );
  }
  searchListener() {
    if (showSearch) {
      packageState.search(searchController.text, true);
    }
  }

  toggleSearch() {
    setState(() {
      showSearch = !showSearch;
      if (!showSearch) packageState.search(searchController.text, false);
    });
  }

  Widget bodyBuilder() {
    return Column(
      children: <Widget>[
        showSearch
            ? SearchField(
          searchController: searchController,
        )
            : SizedBox(),
        Expanded(
          child: listBuilder(),
        ),
      ],
    );
  }

  Widget listBuilder() {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: packageState.loadData,
      child: StreamBuilder<List<Package>>(
        stream: packageState.list,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                var v = snapshot.data[i];
                return PartTile(
                  /*image: v.picture,
                  url: v.path ?? '',*/
                  title: v.packageName,
                  price: v.packageFee,
                  index: i,
                  onAdd: (i) {
                    Navigator.pop(context, v);
                  },
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  navigate2filterPage(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PackageFilterPage()),
    );
  }
}
