import 'package:colornames/colornames.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/main_layout/favourite/presentation/widgets/custom_txt_widget.dart';
import 'package:ecommerce_app/features/products_screen/data/model/ProductModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteItemDetails extends StatelessWidget {
  const FavouriteItemDetails({required this.product, super.key});

  final ProductModel product;
  bool hasDiscount(String? discountStr) {
    final parsed = double.tryParse(discountStr ?? "");
    return parsed != null && parsed > 0;
  }

  @override
  Widget build(BuildContext context) {
    final discount =
        double.tryParse(product.discountInPercentage ?? "0") ?? 0.0;
    final discountedPrice = (product.price ?? 0.0) * (1 - (discount / 100));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomTextWgt(
          data: product.name ?? "",
          textStyle: getSemiBoldStyle(
              color: ColorManager.primaryDark, fontSize: AppSize.s18.sp),
        ),
        Row(
          children: [
            // Container(
            //   margin: EdgeInsets.only(right: AppSize.s10.w),
            //   width: AppSize.s14.w,
            //   height: AppSize.s14.h,
            //   decoration: BoxDecoration(
            //       color: Colors.black, shape: BoxShape.circle),
            // ),
            CustomTextWgt(
              data: 'EGP ${discountedPrice}  ',
              textStyle: getSemiBoldStyle(
                      color: ColorManager.primaryDark, fontSize: AppSize.s18.sp)
                  .copyWith(
                letterSpacing: 0.17,
              ),
            ),
          ],
        ),
        Row(
          children: [
            product.totalPrice == null
                ? const SizedBox.shrink()
                : Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: AppSize.s10.h,
                        ),
                        CustomTextWgt(
                          data: hasDiscount(product.discountInPercentage)
                              ? "${product.price} EGP"
                              : "",
                          textStyle: getMediumStyle(
                            color:
                                ColorManager.appBarTitleColor.withOpacity(.6),
                          ).copyWith(
                            letterSpacing: 0.17,
                            decoration: TextDecoration.lineThrough,
                            fontSize: AppSize.s10.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}
