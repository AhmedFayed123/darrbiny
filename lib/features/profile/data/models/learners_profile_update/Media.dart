class Media {
  Media({
    this.id,
    this.modelType,
    this.modelId,
    this.uuid,
    this.collectionName,
    this.name,
    this.fileName,
    this.mimeType,
    this.disk,
    this.conversionsDisk,
    this.size,
    this.manipulations,
    this.customProperties,
    this.generatedConversions,
    this.responsiveImages,
    this.orderColumn,
    this.createdAt,
    this.updatedAt,
    this.originalUrl,
    this.previewUrl,
  });

  Media.fromJson(dynamic json) {
    id = json['id'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    uuid = json['uuid'];
    collectionName = json['collection_name'];
    name = json['name'];
    fileName = json['file_name'];
    mimeType = json['mime_type'];
    disk = json['disk'];
    conversionsDisk = json['conversions_disk'];
    size = json['size'];
    manipulations = json['manipulations'] ?? [];
    customProperties = json['custom_properties'] ?? [];
    generatedConversions = json['generated_conversions'] ?? [];
    responsiveImages = json['responsive_images'] ?? [];
    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    originalUrl = json['original_url'];
    previewUrl = json['preview_url'];
  }

  int? id;
  String? modelType;
  int? modelId;
  String? uuid;
  String? collectionName;
  String? name;
  String? fileName;
  String? mimeType;
  String? disk;
  String? conversionsDisk;
  int? size;
  List<dynamic>? manipulations;
  List<dynamic>? customProperties;
  List<dynamic>? generatedConversions;
  List<dynamic>? responsiveImages;
  int? orderColumn;
  String? createdAt;
  String? updatedAt;
  String? originalUrl;
  String? previewUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['model_type'] = modelType;
    map['model_id'] = modelId;
    map['uuid'] = uuid;
    map['collection_name'] = collectionName;
    map['name'] = name;
    map['file_name'] = fileName;
    map['mime_type'] = mimeType;
    map['disk'] = disk;
    map['conversions_disk'] = conversionsDisk;
    map['size'] = size;
    map['manipulations'] = manipulations;
    map['custom_properties'] = customProperties;
    map['generated_conversions'] = generatedConversions;
    map['responsive_images'] = responsiveImages;
    map['order_column'] = orderColumn;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['original_url'] = originalUrl;
    map['preview_url'] = previewUrl;
    return map;
  }
}
