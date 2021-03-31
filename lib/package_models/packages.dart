

class Package {
  int packageId;
  int serviceId;
  String packageName;
  double packageFee;
}

enum PartSort {
  latest,
  lowPrice,
  highPrice,
}

List<Package> partSearchMap(List<Package> e, String str) {
  if (str != '')
    e = e.where((v) {
      if (v.packageName.toLowerCase().contains(str.toLowerCase())) return true;
      if (v.packageName.toLowerCase().contains(str.toLowerCase())) return true;
      return false;
    }).toList();
  return e;
}

List<Package> partSortMap(List<Package> e, PartSort s) {
  switch (s) {
    case PartSort.lowPrice:
      e.sort((a, b) => a.packageFee.toInt() - b.packageFee.toInt());
      break;
    case PartSort.highPrice:
      e.sort((a, b) => b.packageFee.toInt() - a.packageFee.toInt());
      break;
    case PartSort.latest:
      e.sort((a, b) => b.serviceId - a.serviceId);
      break;
    default:
  }
  return e;
}