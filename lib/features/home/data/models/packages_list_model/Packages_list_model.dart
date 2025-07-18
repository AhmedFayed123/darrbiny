import 'Packages.dart';

class PackagesListModel {
  PackagesListModel({
      this.packages, 
      this.message,});

  PackagesListModel.fromJson(dynamic json) {
    if (json['packages'] != null) {
      packages = [];
      json['packages'].forEach((v) {
        packages?.add(Packages.fromJson(v));
      });
    }
    message = json['message'];
  }
  List<Packages>? packages;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (packages != null) {
      map['packages'] = packages?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }

}