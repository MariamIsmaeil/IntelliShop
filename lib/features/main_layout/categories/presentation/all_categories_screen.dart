import 'package:ecommerce_app/core/DI/DI.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/widget/home_screen_app_bar.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/ProductsByCategoryScreen.dart';
import 'package:ecommerce_app/features/main_layout/home/presentation/manager/home_cubit.dart';
import 'package:ecommerce_app/features/main_layout/home/presentation/widgets/custom_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..GetCategories(),
      child: Scaffold(
        appBar: const HomeScreenAppBar(),
        body: BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) =>
              current is HomeCategoriesSuccessState ||
              current is HomeCategoriesErrorState ||
              current is HomeCategoriesLoadingState,
          builder: (context, state) {
            if (state is HomeCategoriesLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeCategoriesSuccessState) {
              final categories = state.categoriesEntity.data ?? [];
              
              if (categories.isEmpty) {
                return Center(
                  child: Text(
                    'No categories found',
                    style: getRegularStyle(color: ColorManager.grey),
                  ),
                );
              }

              return Padding(
                padding: EdgeInsets.all(8.w),
                child: GridView.builder(
                  padding: EdgeInsets.all(6.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 15.w,
                    mainAxisSpacing: 15.h,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final categoryName = category.name ?? 'Unnamed Category';
                    final categorySlug = category.slug;

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductsByCategoryScreen(
                              categorySlug: categorySlug,
                              categoryName: categoryName,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(4.w),
                        child: CustomCategoryWidget(
                          state.categoriesEntity.data![index], // Updated to match your widget's constructor
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is HomeCategoriesErrorState) {
              return Center(
                child: Text(
                  state.error,
                  style: getRegularStyle(color: ColorManager.error),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}