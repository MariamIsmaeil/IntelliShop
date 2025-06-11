import 'package:ecommerce_app/features/main_layout/categories/domain/entity/SubCategoriesEntity/SubCategoriesEntity.dart';
import 'SubCategoryModel.dart';

class SubCategoriesResponse {
  SubCategoriesResponse({
    this.success,
    this.message,
    this.data,
  });

  SubCategoriesResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SubCategoryModel.fromJson(v));
      });
    }
  }
  bool? success;
  String? message;
  List<SubCategoryModel>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  SubCategoriesEntity toSubCategoriesEntity() {
    return SubCategoriesEntity(
      data: data?.map((model) => model.toSubCategoryEntity()).toList(),
    );
  }
}