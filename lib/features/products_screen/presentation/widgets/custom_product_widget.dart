import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/constants_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/core/widget/heart_button.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/ProductEntity.dart';
import 'package:ecommerce_app/features/products_screen/presentation/manager/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CustomProductWidget extends StatelessWidget {
  final double width;
  final double height;
  final ProductEntity product;

  const CustomProductWidget({
    super.key,
    required this.width,
    required this.height,
    required this.product,
  });

  String truncateTitle(String title) {
    List<String> words = title.split(' ');
    if (words.length <= 2) {
      return title;
    } else {
      return "${words.sublist(0, 2).join(' ')}..";
    }
  }

  String truncateDescription(String description) {
    List<String> words = description.split(RegExp(r'[\s-]+'));
    if (words.length <= 4) {
      return description;
    } else {
      return "${words.sublist(0, 4).join(' ')}..";
    }
  }

  bool hasDiscount(String? discountStr) {
    final parsed = double.tryParse(discountStr ?? "");
    return parsed != null && parsed > 0;
  }

  @override
  Widget build(BuildContext context) {
    final discount =
        double.tryParse(product.discountInPercentage ?? "0") ?? 0.0;
    final discountedPrice = (product.price ?? 0.0) * (1 - (discount / 100));

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.productDetails,
        arguments: product,
      ),
      child: Container(
        width: width * 0.50,
        height: height * 0.40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Section
            Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                ),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: product.imageCover ?? "",
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: ColorManager.primary,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.image_not_supported,
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: HeartButton(
                        productId: product.id!,
                        onTap: () {
                          ProductsCubit.get(context)
                              .AddProductWish(product.id!);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("The Product is successfully added"),
                              backgroundColor: ColorManager.primary,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Content Section
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title and Description
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          truncateTitle(product.title ?? ""),
                          style: getMediumStyle(
                            color: ColorManager.textColor,
                            fontSize: 14.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2),
                        Text(
                          truncateDescription(product.description ?? ""),
                          style: getRegularStyle(
                            color: ColorManager.grey,
                            fontSize: 12.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),                     // Price and Add Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              NumberFormat.currency(name: "EGP", symbol: "")
                                  .format(discountedPrice),
                              style: getMediumStyle(
                                color: ColorManager.primary,
                                fontSize: 14.sp,
                              ),
                            ),
                            if (hasDiscount(product.discountInPercentage))
                              Text(
                                "${product.price} EGP",
                                style: getTextWithLine(),
                              ),
                          ],
                        ),
                        BlocConsumer<ProductsCubit, ProductsState>(
                          listenWhen: (previous, current) {
                            return current is AddCartLoadingState ||
                                current is AddCartErrorState ||
                                current is AddCartSuccessState;
                          },
                          buildWhen: (previous, current) {
                            return current is AddCartLoadingState ||
                                current is AddCartErrorState ||
                                current is AddCartSuccessState;
                          },
                          listener: (context, state) {
                            if (state is AddCartSuccessState &&
                                state.productId == product.id) {
                              AppConstants.showToast(state.entity.message!);
                            }
                            if (state is AddCartErrorState &&
                                state.productId == product.id) {
                              AppConstants.showToast(state.error);
                            }
                          },
                          builder: (context, state) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: InkWell(
                                onTap: () {
                                  ProductsCubit.get(context).AddProductToCart(
                                    product.id!,
                                    product.quantity?.toString() ?? "1",
                                  );
                                },
                                child: Container(
                                  height: 24.h,
                                  width: 24.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorManager.primary,
                                  ),
                                  child: state is AddCartLoadingState &&
                                          state.id == product.id!
                                      ? Center(
                                          child: SizedBox(
                                            height: 14.h,
                                            width: 14.w,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          ),
                                        )
                                      : Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 16.sp,
                                        ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

