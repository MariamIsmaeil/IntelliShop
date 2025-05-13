import 'package:ecommerce_app/features/main_layout/categories/data/model/SubCategoriesResponse/SubCategoryModel.dart';
import 'package:ecommerce_app/features/main_layout/home/data/models/BrandsResponse/BrandModel.dart';
import 'package:ecommerce_app/features/main_layout/home/data/models/CategoriesResponse/CategoryModel.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/ProductEntity.dart';

class ProductModel {
  ProductModel({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.image,
    this.price,
    this.quantity,
    this.condition,
    this.discountInPercentage,
    this.totalPrice,
    this.status,
    this.brand,
    this.category,
    this.createdAt,
  });

  ProductModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    image = json['image'];
    price = double.tryParse(json['price'].toString()) ?? 0.0;
    quantity = json['quantity'];
    condition = json['condition'];
    discountInPercentage = json['discount_in_percentage'];
    totalPrice = double.tryParse(json['total_price'].toString()) ?? 0.0;
    status = json['status'];
    brand = json['brand'] != null ? BrandModel.fromJson(json['brand']) : null;
    category = json['category'] != null ? CategoryModel.fromJson(json['category']) : null;
    createdAt = json['created_at'];
  }

  int? id;
  String? name;
  String? slug;
  String? description;
  String? image;
  double? price;
  int? quantity;
  String? condition;
  String? discountInPercentage;
  double? totalPrice;
  int? status;
  BrandModel? brand;
  CategoryModel? category;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['description'] = description;
    map['image'] = image;
    map['price'] = price;
    map['quantity'] = quantity;
    map['condition'] = condition;
    map['discount_in_percentage'] = discountInPercentage;
    map['total_price'] = totalPrice;
    map['status'] = status;
    if (brand != null) {
      map['brand'] = brand?.toJson();
    }
    if (category != null) {
      map['category'] = category?.toJson();
    }
    map['created_at'] = createdAt;
    return map;
  }

  ProductEntity toProductEntity() {
    return ProductEntity(
      id: id.toString(),
      title: name,
      slug: slug,
      description: description,
      imageCover: image,
      price: price,
      quantity: quantity,
      brand: brand?.toBrandEntity(),
      category: category?.toCategoryEntity(),
      //subCategory: category?.subcategories?.map((e) => e.toSubCategoryEntity()).toList(),
    );
  }
}