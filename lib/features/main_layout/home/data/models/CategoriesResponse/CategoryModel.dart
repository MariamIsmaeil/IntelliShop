import 'package:ecommerce_app/features/main_layout/categories/data/model/SubCategoriesResponse/SubCategoryModel.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/CategoriesEntity/CategoriesEntity.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/CategoriesEntity/CategoryEntity.dart';



class CategoryModel {
  CategoryModel({
      this.id, 
      this.name, 
      required this.slug, 
      this.image, 
      this.createdAt, 
      this.updatedAt,
      this.subCategories
      });

  CategoryModel.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug']??'';
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['sub_categories'] != null) {
    subCategories = [];
    json['sub_categories'].forEach((v) {
      subCategories!.add(SubCategoryModel.fromJson(v));
    });
  }
  }
  String? id;
  String? name;
 late String slug;
  String? image;
  String? createdAt;
  String? updatedAt;
  List<SubCategoryModel>? subCategories;


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
      subCategories: subCategories?.map((e) => e.toSubCategoryEntity()).toList() ?? [],
    );
  }

}