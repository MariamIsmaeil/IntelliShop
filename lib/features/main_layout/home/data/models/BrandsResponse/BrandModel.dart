import 'package:ecommerce_app/features/main_layout/home/domain/entities/BrandsResponseEntity/BrandEntity.dart';

class BrandModel {
  BrandModel({
    this.id, 
    this.name, 
    required this.slug, 
    this.description,
    this.logoUrl, 
    this.coverUrl,
    this.status,
    this.createdAt, 
    this.updatedAt,
  });

  BrandModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    logoUrl = json['logo_url'];
    coverUrl = json['cover_url'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  
  int? id;
  String? name;
  late String slug;
  String? description;
  String? logoUrl;
  String? coverUrl;
  int? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['description'] = description;
    map['logo_url'] = logoUrl;
    map['cover_url'] = coverUrl;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

  BrandEntity toBrandEntity() {
  return BrandEntity(
    id: id.toString(),
    name: name,
    image: logoUrl,
    slug:slug // هنا يتم تعيين logo_url إلى image
  );
}
}