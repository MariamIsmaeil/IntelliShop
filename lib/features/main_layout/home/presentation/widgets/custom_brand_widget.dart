import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/features/main_layout/home/domain/entities/BrandsResponseEntity/BrandEntity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';

class CustomBrandWidget extends StatelessWidget {
  final BrandEntity brandEntity;
  
  const CustomBrandWidget({
    super.key,
    required this.brandEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // صورة العلامة التجارية
        Container(
          width: 90.w,
          height: 90.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: brandEntity.image != null 
                ? DecorationImage(
                    image: CachedNetworkImageProvider(brandEntity.image!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: brandEntity.image == null
              ? ClipOval(
                  child: Image.asset(
                    ImageAssets.categoryHomeImage,
                    fit: BoxFit.cover,
                  ),
                )
              : null,
        ),

        SizedBox(height: 8.h),
        Expanded(
          child: Text(
            brandEntity.name ?? "",
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: getRegularStyle(
              color: ColorManager.darkBlue, 
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }
}