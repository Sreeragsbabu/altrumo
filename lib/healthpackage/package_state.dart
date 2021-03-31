import 'dart:convert';

import 'package:demo_altrumo/utils/api_links.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

import 'package:demo_altrumo/models/filter_package.dart';
import 'package:demo_altrumo/models/packages.dart';
import 'package:demo_altrumo/package_models/filter_package.dart';
import 'package:demo_altrumo/package_models/packages.dart';

class PackageState {
  static const String packages = '${APILinks.hisServerUrl}mobile/packages';

  var _all = List<Filter>();
  var _sort = PartSort.latest;
  String _searchString = '';
  bool _searchEnabled = false;
  PackageFilter _filter = PackageFilter();
  var _list = BehaviorSubject<List<Filter>>();

  Stream<List<Package>> get list => _list.stream
      .map((e) => _filter.filters(e))
      .map((e) => _searchEnabled ? partSearchMap(e, _searchString) : e)
      .map((e) => partSortMap(e, _sort))
  ;

  get searchEnable => _searchEnabled;
  get searchString => _searchString;
  //tempory geter for filter page will delete when refactory filter page to rxdart
  get all => _all;
  get filter => _filter;

  _update() => _list.add(_all);

  Future<void> loadData() async {
   //var data = await http.get('https://run.mocky.io/v3/a08c4aac-20f0-4f62-be51-86fe4af7bfcf');   working
    //var data = await http.get('https://run.mocky.io/v3/80162306-43db-4fba-af87-80d5bad6c754');
    //final string = 'http://10.10.10.92:8080/getPackages';
    final string = packages;
    var data = await http.get(string);
    /*String bodyText = data.body;
    print(bodyText);*/
    final jsonString = json.decode(data.body);
    _all.clear();
    jsonString.forEach((v) {
      final vga = Filter.fromJson(v);
      _all.add(vga);
    });
    _update();

    /*if (data.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      final jsonString = json.decode(data.body);
     // print (data.statusCode);
     // print(data.body);
      _all.clear();
      jsonString.forEach((v) {
        final vga = Vga.fromJson(v);
        _all.add(vga);
      });
      _update();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }*/

  }

  setFilter(PackageFilter f) {
    _filter = f;
    _update();
  }

  search(String txt, bool enable) {
    _searchString = txt;
    _searchEnabled = enable;
    _update();
  }

  sort(PartSort s) {
    _sort = s;
    _update();
  }
}

var packageState = PackageState();
