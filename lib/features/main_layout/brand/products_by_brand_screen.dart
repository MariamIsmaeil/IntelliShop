import 'package:ecommerce_app/core/DI/DI.dart';
import 'package:ecommerce_app/core/network/api_manager.dart';
import 'package:ecommerce_app/core/network/endpoint.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/BrandsResponseEntity/BrandEntity.dart';
import 'package:ecommerce_app/features/products_screen/data/model/ProductsResponseModel.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/ProductEntity.dart';
import 'package:ecommerce_app/features/products_screen/presentation/widgets/custom_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsByBrandScreen extends StatefulWidget {
  final String brandSlug;
  final String brandName;

  const ProductsByBrandScreen({
    super.key,
    required this.brandSlug,
    required this.brandName,
  });

  @override
  State<ProductsByBrandScreen> createState() => _ProductsByBrandScreenState();
}

class _ProductsByBrandScreenState extends State<ProductsByBrandScreen> {
  final ApiManager _apiManager = getIt<ApiManager>();
  List<ProductEntity> products = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _fetchProductsByBrand();
  }

  Future<void> _fetchProductsByBrand() async {
    try {
      final response = await _apiManager.GetRequest(
        Endpoint.productsByBrandEndpoint(widget.brandSlug),
      );

      final productsResponse = ProductsResponseModel.fromJson(response.data);
      
      if (productsResponse.success == true) {
        setState(() {
          products = productsResponse.data?.map((productModel) => productModel.toProductEntity()).toList() ?? [];
          isLoading = false;
        });
      } else {
        setState(() {
          error = productsResponse.message ?? 'Failed to load products';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error loading products: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.brandName),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : products.isEmpty
                  ? const Center(child: Text('No products available for this brand'))
                  : GridView.builder(
                      padding: EdgeInsets.all(16.w),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.w,
                        mainAxisSpacing: 16.h,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: products?.length ?? 0,
                      itemBuilder: (context, index) {
                        return CustomProductWidget(
                          product: products[index],
                          width: 180.w,
                          height: 180.h,
                        );
                      },
                    ),
    );
  }
}