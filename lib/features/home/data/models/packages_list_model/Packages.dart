class Packages {
  Packages({
      this.id, 
      this.name, 
      this.description, 
      this.daysCount, 
      this.hoursCount, 
      this.price, 
      this.deletedAt, 
      this.createdAt, 
      this.updatedAt,});

  Packages.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    daysCount = json['days_count'];
    hoursCount = json['hours_count'];
    price = json['price'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? name;
  String? description;
  int? daysCount;
  int? hoursCount;
  String? price;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['days_count'] = daysCount;
    map['hours_count'] = hoursCount;
    map['price'] = price;
    map['deleted_at'] = deletedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}