import 'package:ecommerce_app/features/main_layout/home/data/models/BrandsResponse/BrandModel.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/BrandsResponseEntity/BrandsResponseEntity.dart';

class BrandsResponseModel {
  BrandsResponseModel({
    this.success,
    this.message,
    this.data,
  });

  BrandsResponseModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BrandModel.fromJson(v));
      });
    }
  }
  
  bool? success;
  String? message;
  List<BrandModel>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  BrandsResponseEntity toBrandsResponseEntity(){
    return BrandsResponseEntity(
      data: data?.map((model) => model.toBrandEntity()).toList()
    );
  }
}