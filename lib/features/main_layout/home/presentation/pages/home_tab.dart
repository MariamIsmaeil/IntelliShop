import 'dart:async';
import 'package:ecommerce_app/features/main_layout/brand/brands_list_screen.dart';
import 'package:ecommerce_app/features/main_layout/brand/products_by_brand_screen.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/ProductsByCategoryScreen.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/all_categories_screen.dart';
import 'package:ecommerce_app/features/main_layout/home/presentation/manager/home_cubit.dart';
import 'package:ecommerce_app/features/main_layout/home/presentation/widgets/custom_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/DI/DI.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../widgets/custom_ads_widget.dart';
import '../widgets/custom_brand_widget.dart';
import '../widgets/custom_section_bar.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentIndex = 0;
  late Timer _timer;

  final List<String> adsImages = [
    ImageAssets.carouselSlider1,
    ImageAssets.carouselSlider2,
    ImageAssets.carouselSlider3,
  ];

  @override
  void initState() {
    super.initState();
    _startImageSwitching();
  }

  void _startImageSwitching() {
    _timer = Timer.periodic(const Duration(milliseconds: 2500), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % adsImages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()
        ..GetCategories()
        ..GetBrands(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomAdsWidget(
                adsImages: adsImages,
                currentIndex: _currentIndex,
                timer: _timer,
              ),
              Column(
                children: [
                  CustomSectionBar(
                      sectionNname: 'Categories',
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AllCategoriesScreen(),
                          ),
                        );
                      }),
                  BlocBuilder<HomeCubit, HomeState>(
                    buildWhen: (previous, current) {
                      if (current is HomeCategoriesLoadingState ||
                          current is HomeCategoriesSuccessState ||
                          current is HomeCategoriesErrorState) {
                        return true;
                      }
                      return false;
                    },
                    builder: (context, state) {
                      if (state is HomeCategoriesSuccessState) {
                        return SizedBox(
                          height: 330.h,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final category =
                                  state.categoriesEntity.data![index];
                              return CustomCategoryWidget(
                                category,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductsByCategoryScreen(
                                        categorySlug: category.slug ?? "",
                                        categoryName: category.name ?? "",
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            itemCount: state.categoriesEntity.data?.length ?? 0,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                            ),
                          ),
                        );
                      }
                      if (state is HomeCategoriesErrorState) {
                        return Center(
                          child: Text(state.error),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                  SizedBox(height: 5.h),
                  CustomSectionBar(
                      sectionNname: 'Brands',
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BrandsListScreen(),
                          ),
                        );
                      }),
                  BlocBuilder<HomeCubit, HomeState>(
                    buildWhen: (previous, current) {
                      if (current is HomeBrandsLoadingState ||
                          current is HomeBrandsSuccessState ||
                          current is HomeBrandsErrorState) {
                        return true;
                      }
                      return false;
                    },
                    builder: (context, state) {
                      if (state is HomeBrandsSuccessState) {
                        return SizedBox(
                          height: 330.h,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                state.brandsResponseEntity.data?.length ?? 0,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                            ),
                            itemBuilder: (context, index) {
                              final brand =
                                  state.brandsResponseEntity.data![index];

                              return CustomBrandWidget(
                                brandEntity: brand,
                                onTap: () {
                                  final slug = brand.slug;
                                  if (slug != null && slug.isNotEmpty) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductsByBrandScreen(
                                          brandSlug: slug,
                                          brandName:
                                              brand.name ?? 'Brand Products',
                                        ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text("This brand has no slug."),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        );
                      }
                      if (state is HomeBrandsErrorState) {
                        return Center(
                          child: Text(state.error),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
