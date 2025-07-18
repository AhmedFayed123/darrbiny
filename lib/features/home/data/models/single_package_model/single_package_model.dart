
import '../packages_list_model/Packages.dart';

class SinglePackageModel {
  SinglePackageModel({
    this.package,
    this.message,
  });

  SinglePackageModel.fromJson(dynamic json) {
    package = json['package'] != null ? Packages.fromJson(json['package']) : null;
    message = json['message'];
  }

  Packages? package;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (package != null) {
      map['package'] = package!.toJson();
    }
    map['message'] = message;
    return map;
  }
}
