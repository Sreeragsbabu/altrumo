/*
import 'packages.dart';

class Filter extends Package {
  String gender;
  String category;

  Filter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    package_name = json['package_name'];
    package_code = json['package_code'];
    price = json['price'] ?? json['lowest_price'] ?? 0;
    gender = json['gender'] ?? '-';
    if (gender == '') gender = '-';
    category = json['category'] ?? '-';
    if (category == '') category = '-';
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['package_name'] = this.package_name;
    data['package_code'] = this.package_code;
    data['price'] = this.price;
    data['gender'] = this.gender;
    data['category'] = this.category;
    return data;
  }
}

class PackageFilter {
  Set<String> package_name;
  Set<String> gender;
  Set<String> category;
  int minPrice;
  int maxPrice;

  PackageFilter() {
    package_name = Set<String>();
    gender = Set<String>();
    category = Set<String>();
    minPrice = 0;
    maxPrice = 1000000;
  }
  PackageFilter.fromList(List<Filter> list) {
    package_name = list.map((v) => v.package_name).toSet();
    gender = list.map((v) => v.gender).toSet();
    category = list.map((v) => v.category).toSet();
    if (list.length > 0) {
      minPrice = list.map((v) => v.price).reduce((a, b) => a < b ? a : b);
      maxPrice = list.map((v) => v.price).reduce((a, b) => a > b ? a : b);
      minPrice = minPrice ~/ 1000 * 1000;
      maxPrice = maxPrice ~/ 1000 * 1000 + 1000;
    } else {
      minPrice = 0;
      maxPrice = 1000000;
    }
  }
  PackageFilter.clone(PackageFilter packageFilter) {
    package_name = packageFilter.package_name.toSet();
    gender = packageFilter.gender.toSet();
    category = packageFilter.category.toSet();
    minPrice = packageFilter.minPrice;
    maxPrice = packageFilter.maxPrice;
  }
  bool filter(Filter pack) {
    if (pack.price < minPrice) return false;
    if (pack.price > maxPrice) return false;
    if (package_name.length != 0 && !package_name.contains(pack.package_name)) return false;
    if (gender.length != 0 && !gender.contains(pack.gender)) return false;
    if (category.length != 0 && !category.contains(pack.category)) return false;
    return true;
  }

  List<Filter> filters(List<Filter> list) {
    List<Filter> result = [];
    list.forEach((v) {
      if (filter(v)) result.add(v);
    });

    return result;
  }
}
*/
