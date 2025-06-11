// brands_list_screen.dart
import 'package:ecommerce_app/features/main_layout/brand/products_by_brand_screen.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/BrandsResponseEntity/BrandsResponseEntity.dart';
import 'package:ecommerce_app/features/main_layout/home/presentation/manager/home_cubit.dart';
import 'package:ecommerce_app/features/main_layout/home/presentation/widgets/custom_brand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/DI/DI.dart';

class BrandsListScreen extends StatelessWidget {
  const BrandsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..GetBrands(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Brands'),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeBrandsSuccessState) {
              return GridView.builder(
                padding: EdgeInsets.all(16.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 0.8,
                ),
                itemCount: state.brandsResponseEntity.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final brand = state.brandsResponseEntity.data![index];
                  return GestureDetector(
                    onTap: () {
                      final slug = brand.slug;
                      if (slug != null && slug.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductsByBrandScreen(
                              brandSlug: slug,
                              brandName: brand.name ?? 'Brand Products',
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("This brand has no slug.")),
                        );
                      }
                    },
                    child: CustomBrandWidget(brandEntity: brand),
                  );
                },
              );
            } else if (state is HomeBrandsErrorState) {
              return Center(child: Text(state.error));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
