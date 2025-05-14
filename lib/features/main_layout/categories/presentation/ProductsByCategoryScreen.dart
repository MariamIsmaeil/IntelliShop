import 'package:ecommerce_app/features/products_screen/domain/entity/ProductEntity.dart';
import 'package:ecommerce_app/features/products_screen/presentation/manager/products_cubit.dart';
import 'package:ecommerce_app/features/products_screen/presentation/widgets/custom_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/DI/DI.dart';
import '../../../../../core/resources/color_manager.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  final String categorySlug;
  final String categoryName;

  const ProductsByCategoryScreen({
    super.key,
    required this.categorySlug,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: BlocProvider(
        create: (context) => getIt<ProductsCubit>()..GetProductsFromCategory(categorySlug),
        child: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductsSuccessState) {
              final products = state.products;
              if (products.isEmpty) {
                return Center(
                  child: Text(
                    'No products found in this category',
                    style: TextStyle(color: ColorManager.grey),
                  ),
                );
              }
              return _buildProductGrid(products);
            } else if (state is ProductsErrorState) {
              return Center(
                child: Text(
                  state.error,
                  style: TextStyle(color: ColorManager.error),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildProductGrid(List<ProductEntity> products) {
    return GridView.builder(
      padding: EdgeInsets.all(16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: CustomProductWidget(
            product: products[index],
            width: 150.w,
            height: 300.h,
          ),
        );
      },
    );
  }
}
