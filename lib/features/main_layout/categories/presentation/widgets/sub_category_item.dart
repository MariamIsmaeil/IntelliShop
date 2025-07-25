import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/manager/categories_cubit.dart';
import 'package:flutter/material.dart';

class SubCategoryItem extends StatelessWidget {
  final String title;
  final String image;
  final Function navigation;
  const SubCategoryItem(this.title, this.image, this.navigation, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.productsScreenRoute,
          arguments: CategoriesCubit.get(context).selectedCategory),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s12),
                  border: Border.all(color: ColorManager.primary, width: 2)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s10),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Text(
            title,
            style: getRegularStyle(color: ColorManager.primary),
          )
        ],
      ),
    );
  }
}
