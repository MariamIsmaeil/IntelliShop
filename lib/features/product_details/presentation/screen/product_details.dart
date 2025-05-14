import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/widget/custom_elevated_button.dart';
import 'package:ecommerce_app/features/product_details/presentation/widgets/product_color.dart';
import 'package:ecommerce_app/features/product_details/presentation/widgets/product_description.dart';
import 'package:ecommerce_app/features/product_details/presentation/widgets/product_item.dart';
import 'package:ecommerce_app/features/product_details/presentation/widgets/product_label.dart';
import 'package:ecommerce_app/features/product_details/presentation/widgets/product_rating.dart';
import 'package:ecommerce_app/features/product_details/presentation/widgets/product_size.dart';
import 'package:ecommerce_app/features/product_details/presentation/widgets/product_slider.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/ProductEntity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ProductDetails extends StatelessWidget {
  final ProductEntity product;
  
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(name: "EGP", decimalDigits: 0);
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Product Details',
          style: getMediumStyle(color: ColorManager.appBarTitleColor)
              .copyWith(fontSize: 20.sp),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: ImageIcon(
                AssetImage(IconsAssets.icSearch),
                color: ColorManager.primary,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: ColorManager.primary,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 50.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              ProductSlider(
                items: [
                  // Use the product's image cover for all slider items
                  // You can modify this to use multiple images if available
                  ProductItem(imageUrl: product.imageCover ?? ''),
                  ProductItem(imageUrl: product.imageCover ?? ''),
                  ProductItem(imageUrl: product.imageCover ?? ''),
                ], 
                initialIndex: 0
              ),
              SizedBox(height: 24.h),
              ProductLabel(
                productName: product.title ?? 'No Title',
                productPrice: currencyFormat.format(product.price ?? 0),
              ),
              SizedBox(height: 16.h),
              const ProductRating(
                productBuyers: '3,230', // You can replace with actual data
                productRating: '4.8 (7,500)', // You can replace with actual data
              ),
              SizedBox(height: 16.h),
              ProductDescription(
                productDescription: product.description ?? 'No description available',
              ),
              ProductSize(
                size: const [35, 38, 39, 40], // You can replace with actual sizes
                onSelected: () {},
              ),
              SizedBox(height: 20.h),
              Text(
                'Color',
                style: getMediumStyle(color: ColorManager.appBarTitleColor)
                    .copyWith(fontSize: 18.sp)),
              ProductColor(
                color: const [
                  Colors.red,
                  Colors.blueAccent,
                  Colors.green,
                  Colors.yellow,
                ], 
                onSelected: () {},
              ),
              SizedBox(height: 48.h),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'Total price',
                        style: getMediumStyle(
                                color: ColorManager.primary.withOpacity(.6))
                            .copyWith(fontSize: 18.sp),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        currencyFormat.format(product.price ?? 0),
                        style: getMediumStyle(color: ColorManager.appBarTitleColor)
                            .copyWith(fontSize: 18.sp))
                    ],
                  ),
                  SizedBox(width: 33.w),
                  Expanded(
                    child: CustomElevatedButton(
                      label: 'Add to cart',
                      onTap: () {},
                      prefixIcon: Icon(
                        Icons.add_shopping_cart_outlined,
                        color: ColorManager.white,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}