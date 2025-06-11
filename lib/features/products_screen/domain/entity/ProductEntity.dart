

import 'package:ecommerce_app/features/main_layout/categories/domain/entity/SubCategoriesEntity/SubCategoryEntity.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/BrandsResponseEntity/BrandEntity.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/CategoriesEntity/CategoryEntity.dart';

class ProductEntity {
  ProductEntity({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imageCover,
    this.price,
    this.quantity,
    this.brand,
    this.category,
    this.subCategory,
    this.discountInPercentage
  });

  String? id;
  String? title;
  String? slug;
  String? description;
  String? imageCover;
  double? price;
  String? discountInPercentage;
  int? quantity;
  BrandEntity? brand;
  CategoryEntity? category;
  List<SubCategoryEntity>? subCategory;
}