/*
class Package {
  int id;
  String package_name;
  String package_code;
  int price;
  String gender;
}

enum PartSort {
  latest,
  lowPrice,
  highPrice,
}

List<Package> partSearchMap(List<Package> e, String str) {
  if (str != '')
    e = e.where((v) {
      if (v.package_name.toLowerCase().contains(str.toLowerCase())) return true;
      if (v.package_code.toLowerCase().contains(str.toLowerCase())) return true;
      return false;
    }).toList();
  return e;
}

List<Package> partSortMap(List<Package> e, PartSort s) {
  switch (s) {
    case PartSort.lowPrice:
      e.sort((a, b) => a.price - b.price);
      break;
    case PartSort.highPrice:
      e.sort((a, b) => b.price - a.price);
      break;
    case PartSort.latest:
      e.sort((a, b) => b.id - a.id);
      break;
    default:
  }
  return e;
}
*/
