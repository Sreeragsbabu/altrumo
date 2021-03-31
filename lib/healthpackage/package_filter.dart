import 'package:flutter/material.dart';
import 'package:demo_altrumo/widgets/filter_chip.dart';

import 'package:demo_altrumo/models/filter_package.dart';
import 'package:demo_altrumo/package_models/filter_package.dart';

import 'package_state.dart';

class PackageFilterPage extends StatefulWidget {
  final PackageFilter selectedFilter = packageState.filter;
  final List<Filter> all = packageState.all;

  @override
  _PackageFilterPageState createState() => _PackageFilterPageState();
}

class _PackageFilterPageState extends State<PackageFilterPage> {
  PackageFilter allFilter;
  PackageFilter validFilter;
  PackageFilter selectedFilter;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    allFilter = PackageFilter.fromList(widget.all);
    validFilter = allFilter;
    selectedFilter = widget.selectedFilter;
    if (selectedFilter.maxPrice > allFilter.maxPrice)
      selectedFilter.maxPrice = allFilter.maxPrice;
    if (selectedFilter.minPrice < allFilter.minPrice)
      selectedFilter.minPrice = allFilter.minPrice;
    //recalFilter();
  }

  resetData() {
    setState(() {
      allFilter = PackageFilter.fromList(widget.all);
      validFilter = allFilter;
      selectedFilter = PackageFilter();
      selectedFilter.minPrice = allFilter.minPrice;
      selectedFilter.maxPrice = allFilter.maxPrice;
    });
  }
  /*recalFilter() {
    setState(() {
      validFilter = PackageFilter.clone(allFilter);
      var tmpFilter = PackageFilter.clone(allFilter);

      //import price
      tmpFilter.minPrice = selectedFilter.minPrice;
      tmpFilter.maxPrice = selectedFilter.maxPrice;

      //finter valid brand
      var tmpList = tmpFilter.filters(widget.all);
      var resultFilter = PackageFilter.fromList(tmpList);
      validFilter.package_name = resultFilter.package_name;
      selectedFilter.package_name =
          selectedFilter.package_name.intersection(validFilter.package_name);

      //import brand
      tmpFilter.package_name = allFilter.package_name.intersection(selectedFilter.package_name);

      //filter valid shipset
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = PackageFilter.fromList(tmpList);
      validFilter.gender = resultFilter.gender;
      selectedFilter.gender =
          selectedFilter.gender.intersection(validFilter.gender);

      //import chipset
      tmpFilter.gender =
          allFilter.gender.intersection(selectedFilter.gender);

      //filter valid series
      tmpList = tmpFilter.filters(widget.all);
      resultFilter = PackageFilter.fromList(tmpList);
      validFilter.category = resultFilter.category;
      selectedFilter.category =
          selectedFilter.category.intersection(validFilter.category);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    // List<String> allBrandList = allFilter.vgaBrand.toList()..sort();
    return Scaffold(
      appBar: AppBar(
        title: Text('Apply Filter'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restore),
            tooltip: 'Reset',
            onPressed: () => resetData(),
          ),
          IconButton(
            icon: Icon(Icons.check_circle_sharp),
            tooltip: 'OK',
            onPressed: () {
              packageState.setFilter(selectedFilter);
              Navigator.pop(context, selectedFilter);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          packageState.setFilter(selectedFilter);
          Navigator.pop(context, selectedFilter);
        },
        icon: Icon(Icons.check_circle_sharp),
        label: Text("Apply"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        /* decoration: MyBackgroundDecoration3(),*/
        child: ListView(
          children: <Widget>[
            filterChipMaker('Gender', allFilter.gender, validFilter.gender,
                selectedFilter.gender),
            filterChipMaker('VisitType', allFilter.visitType,
                validFilter.visitType, selectedFilter.visitType),
            /*Container(
              margin: EdgeInsets.all(8),
              child: RaisedButton(
                child: Text('Apply'),
                color: Colors.blueAccent,
                onPressed: () {
                  packageState.setFilter(selectedFilter);
                  Navigator.pop(context, selectedFilter);
                },
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  Text titleText(String txt) {
    return Text(
      txt,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget clearAllMaker(Set<String> selected) {
    return FlatButton(
      child: Text(
        'clear',
        style: TextStyle(color: Colors.blue),
      ),
      onPressed: selected.length == 0
          ? null
          : () {
              setState(() {
                selected.clear();
              });
            },
    );
  }

  Widget filterChipMaker(
    String label,
    Set<String> all,
    Set<String> valid,
    Set<String> selected,
  ) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleText(label),
          clearAllMaker(selected),
      ],
    ),
          subtitle: FilterChips(
            all: all,
            valid: valid,
            selected: selected,
            onSelected: (str) {
              setState(() {
                selected.add(str);
              });
            },
            onDeselected: (str) {
              setState(() {
                selected.remove(str);
              });
            },
          ),
        ),
      ],
    );
  }
}
