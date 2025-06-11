import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/ProductsByCategoryScreen.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/manager/categories_cubit.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/widgets/category_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sub_category_item.dart';

class SubCategoriesList extends StatelessWidget {
  const SubCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      buildWhen: (previous, current) => current is SelectNewCategoryState,
      builder: (context, state) {
        final cubit = CategoriesCubit.get(context);
        final selectedCategory = cubit.selectedCategory;
        final subCategories = selectedCategory?.subCategories ?? [];

        return Expanded(
          flex: 2,
          child: CustomScrollView(
            slivers: <Widget>[
              // Category title
              SliverToBoxAdapter(
                child: Text(
                  selectedCategory?.name ?? "",
                  style: getBoldStyle(
                    color: ColorManager.primary,
                    fontSize: FontSize.s14,
                  ),
                ),
              ),

              // Category Card
              SliverToBoxAdapter(
                child: InkWell(
                  onTap: () {
                    if (selectedCategory != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsByCategoryScreen(
                            categorySlug: selectedCategory.slug,
                            categoryName: selectedCategory.name ?? "",
                          ),
                        ),
                      );
                    }
                  },
                  child: CategoryCardItem(
                    selectedCategory?.name ?? "",
                    selectedCategory?.image ?? "",
                    goToCategoryProductsListScreen,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 15)),

              // Subcategories grid or empty message
              subCategories.isEmpty
                  ? SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p12),
                        child: Center(
                          child: Text(
                            "No subcategories",
                            style: getRegularStyle(
                              color: ColorManager.grey,
                              fontSize: FontSize.s14,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => SubCategoryItem(
                          subCategories[index].name ?? "",
                          subCategories[index].image ?? "",
                          goToCategoryProductsListScreen,
                        ),
                        childCount: subCategories.length,
                      ),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1 / 1.8,
                        mainAxisSpacing: AppSize.s4,
                        crossAxisSpacing: AppSize.s8,
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }

  void goToCategoryProductsListScreen() {
    // TODO: implement navigation when subcategory is tapped (optional)
  }
}
