import 'package:ecommerce_app/features/main_layout/categories/domain/entity/SubCategoriesEntity/SubCategoryEntity.dart';

class SubCategoryModel {
  SubCategoryModel({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.image
  });

  SubCategoryModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    image=json['image'];
  }
  int? id;
  String? name;
  String? slug;
  String? description;
  String?image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['description'] = description;
    map['image']=image;
    return map;
  }

  SubCategoryEntity toSubCategoryEntity() {
    return SubCategoryEntity(
      id: id.toString(),
      name: name,
      image: image,
      
    );
  }
}