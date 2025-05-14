import 'package:ecommerce_app/features/main_layout/home/domain/entities/CategoriesEntity/CategoriesEntity.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/CategoriesEntity/CategoryEntity.dart';



class CategoryModel {
  CategoryModel({
      this.id, 
      this.name, 
      required this.slug, 
      this.image, 
      this.createdAt, 
      this.updatedAt,});

  CategoryModel.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug']??'';
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  String? id;
  String? name;
 late String slug;
  String? image;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['image'] = image;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

  CategoryEntity toCategoryEntity(){
    return CategoryEntity(
      id: id,
      name: name,
      image: image,
      slug: slug,
    );
  }

}