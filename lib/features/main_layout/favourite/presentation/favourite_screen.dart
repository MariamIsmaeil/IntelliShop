import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/constants_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/main_layout/favourite/presentation/viewmodel/favourite_cubit.dart';
import 'package:ecommerce_app/features/main_layout/favourite/presentation/widgets/favourite_item.dart';
import 'package:ecommerce_app/features/products_screen/presentation/manager/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/DI/DI.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavouriteCubit>(
          create: (_) => getIt<FavouriteCubit>()..GetWishlist(),
        ),
        BlocProvider<ProductsCubit>(
          create: (_) => getIt<ProductsCubit>(),
        ),
      ],
      child: BlocBuilder<FavouriteCubit, FavouriteState>(
        builder: (context, state) {
          if (state is FavouriteSuccessState) {
            if (state.products.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    "From empty to extraordinary—your wishlist journey begins here.",
                    textAlign: TextAlign.center,
                    style: getMediumStyle(
              color: ColorManager.primary,
              fontSize: FontSize.s18,
            ),
                  ),
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSize.s14.w, vertical: AppSize.s10.h),
              child: ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSize.s12.h),
                    child: FavoriteItem(
                      product: product,
                      onDelete: () async {
                        await ProductsCubit.get(context)
                            .removeProductFromWishlist(product.id!.toString());
                        // بعد الحذف نعيد تحميل wishlist
                        await FavouriteCubit.get(context).GetWishlist();
                      },
                    ),
                  );
                },
              ),
            );
          }
          if (state is FavouriteErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

