import 'packages.dart';

class Filter extends Package {
  String gender;
  String visitType;

  Filter.fromJson(Map<String, dynamic> json) {
    packageId = json['packageId'];
    serviceId = json['serviceId'];
    packageName = json['packageName'];
    packageFee = json['packageFee'];
    gender = json['gender'] ?? '-';
    if (gender == '') gender = '-';
    visitType = json['visitType'] ?? '-';
    if (visitType == '') visitType = '-';
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['packageId'] = this.packageId;
    data['serviceId'] = this.serviceId;
    data['packageName'] = this.packageName;
    data['packageFee'] = this.packageFee;
    data['gender'] = this.gender;
    data['visitType'] = this.visitType;
    return data;
  }
}

class PackageFilter {
  Set<String> packageName;
  Set<String> gender;
  Set<String> visitType;
  double minPrice;
  double maxPrice;

  PackageFilter() {
    packageName = Set<String>();
    gender = Set<String>();
    visitType = Set<String>();
    minPrice = 0;
    maxPrice = 1000000;
  }
  PackageFilter.fromList(List<Filter> list) {
    packageName = list.map((v) => v.packageName).toSet();
    gender = list.map((v) => v.gender).toSet();
    visitType = list.map((v) => v.visitType).toSet();
    if (list.length > 0) {
      minPrice = list.map((v) => v.packageFee).reduce((a, b) => a < b ? a : b);
      maxPrice = list.map((v) => v.packageFee).reduce((a, b) => a > b ? a : b);
      minPrice = minPrice ~/ 1000 * 1000.toDouble();
      maxPrice = maxPrice ~/ 1000 * 1000 + 1000.toDouble();
    } else {
      minPrice = 0;
      maxPrice = 1000000;
    }
  }
  PackageFilter.clone(PackageFilter packageFilter) {
    packageName = packageFilter.packageName.toSet();
    gender = packageFilter.gender.toSet();
    visitType = packageFilter.visitType.toSet();
    minPrice = packageFilter.minPrice;
    maxPrice = packageFilter.maxPrice;
  }
  bool filter(Filter pack) {
    if (pack.packageFee < minPrice) return false;
    if (pack.packageFee > maxPrice) return false;
    if (packageName.length != 0 && !packageName.contains(pack.packageName)) return false;
    if (gender.length != 0 && !gender.contains(pack.gender)) return false;
    if (visitType.length != 0 && !visitType.contains(pack.visitType)) return false;
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