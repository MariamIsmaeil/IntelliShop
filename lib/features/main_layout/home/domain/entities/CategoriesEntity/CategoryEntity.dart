import 'package:ecommerce_app/features/main_layout/categories/domain/entity/SubCategoriesEntity/SubCategoryEntity.dart';

/// _id : "6439d61c0049ad0b52b90051"
/// name : "Music"
/// image : "https://ecommerce.routemisr.com/Route-Academy-categories/1681511964020.jpeg"

class CategoryEntity {
  CategoryEntity({
      this.id, 
      this.name, 
      this.image,required this.slug,this.subCategories});
  String? id;
  String? name;
  String? image;
  String slug;
  List<SubCategoryEntity>? subCategories;


}