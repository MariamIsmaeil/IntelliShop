// import 'package:ecommerce_app/core/prefrences/PrefsHandler.dart';
// import 'package:ecommerce_app/core/resources/assets_manager.dart';
// import 'package:ecommerce_app/core/resources/color_manager.dart';
// import 'package:ecommerce_app/core/resources/constants_manager.dart';
// import 'package:ecommerce_app/core/resources/font_manager.dart';
// import 'package:ecommerce_app/core/resources/styles_manager.dart';
// import 'package:ecommerce_app/core/resources/values_manager.dart';
// import 'package:ecommerce_app/core/routes_manager/routes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';

// class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final bool? automaticallyImplyLeading;
//   const HomeScreenAppBar({super.key, this.automaticallyImplyLeading});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       surfaceTintColor: Colors.white,
//       automaticallyImplyLeading: automaticallyImplyLeading ?? false,
//       // title: SvgPicture.asset(
//       //   SvgAssets.routeLogo,
//       //   height: 25.h,
//       //   width: 25.w,
//       //   colorFilter:
//       //       const ColorFilter.mode(ColorManager.textColor, BlendMode.srcIn),
//       // ),
//       title: Text(
//         "Intellige Shop",
//         style: TextStyle(color: ColorManager.primary),
//       ),
//       actions: [
//         IconButton(
//             onPressed: () {
//               PrefsHandler.clearToken();
//               AppConstants.showToast("Logged out");
//               Navigator.pushNamedAndRemoveUntil(
//                   context, Routes.signInRoute, (route) => false);
//             },
//             icon: Icon(Icons.logout))
//       ],
//       bottom: PreferredSize(
//           preferredSize: const Size(AppSize.s100, AppSize.s60),
//           child: Padding(
//             padding: const EdgeInsets.all(AppPadding.p8),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     cursorColor: ColorManager.primary,
//                     style: getRegularStyle(
//                         color: ColorManager.primary, fontSize: FontSize.s16),
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.symmetric(
//                           horizontal: AppMargin.m12.w,
//                           vertical: AppMargin.m8.h),
//                       focusedErrorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10000),
//                           borderSide: BorderSide(
//                               width: AppSize.s1, color: ColorManager.primary)),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10000),
//                           borderSide: BorderSide(
//                               width: AppSize.s1, color: ColorManager.primary)),
//                       disabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10000),
//                           borderSide: BorderSide(
//                               width: AppSize.s1, color: ColorManager.primary)),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10000),
//                           borderSide: BorderSide(
//                               width: AppSize.s1, color: ColorManager.primary)),
//                       errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10000),
//                           borderSide: BorderSide(
//                               width: AppSize.s1, color: ColorManager.error)),
//                       prefixIcon: ImageIcon(
//                         AssetImage(IconsAssets.icSearch),
//                         color: ColorManager.primary,
//                       ),
//                       hintText: "what do you search for?",
//                       hintStyle: getRegularStyle(
//                           color: ColorManager.primary, fontSize: FontSize.s16),
//                     ),
//                   ),
//                 ),

//                 IconButton(
//                   onPressed: () {
//                     print('Saved token: ${PrefsHandler.getToken()}');
//                     Navigator.pushNamed(context, Routes.cartRoute);
//                   },
//                   icon: ImageIcon(
//                     AssetImage(IconsAssets.icCart),
//                     color: ColorManager.primary,
//                   ),
//                 ),
//               ],
//             ),
//           )),
//       // leading: const SizedBox.shrink(),
//     );
//   }

//   @override
//   Size get preferredSize => Size(0, 130.h);
// }
import 'package:ecommerce_app/core/prefrences/PrefsHandler.dart';
import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/constants_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/features/search/presentation/manger/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreenAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool? automaticallyImplyLeading;
  const HomeScreenAppBar({Key? key, this.automaticallyImplyLeading}) : super(key: key);

  @override
  State<HomeScreenAppBar> createState() => _HomeScreenAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(130.h);
}

class _HomeScreenAppBarState extends State<HomeScreenAppBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchSubmitted(String value) {
    final trimmedValue = value.trim();
    if (trimmedValue.isNotEmpty) {
      final searchCubit = context.read<SearchCubit>();
      searchCubit.searchProducts(trimmedValue);

      Navigator.pushNamed(
        context,
        Routes.searchRoute,
        arguments: trimmedValue,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.white,
      automaticallyImplyLeading: widget.automaticallyImplyLeading ?? false,
      title: Text(
        "Intellige Shop",
        style: TextStyle(color: ColorManager.primary),
      ),
      actions: [
        IconButton(
          onPressed: () {
            PrefsHandler.clearToken();
            AppConstants.showToast("Logged out");
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.signInRoute, (route) => false);
          },
          icon: Icon(Icons.logout),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size(AppSize.s100, AppSize.s60),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _searchController,
                  cursorColor: ColorManager.primary,
                  style: getRegularStyle(
                      color: ColorManager.primary, fontSize: FontSize.s16),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: AppMargin.m12.w, vertical: AppMargin.m8.h),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10000),
                        borderSide:
                            BorderSide(width: AppSize.s1, color: ColorManager.primary)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10000),
                        borderSide:
                            BorderSide(width: AppSize.s1, color: ColorManager.primary)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10000),
                        borderSide:
                            BorderSide(width: AppSize.s1, color: ColorManager.primary)),
                    prefixIcon: ImageIcon(
                      AssetImage(IconsAssets.icSearch),
                      color: ColorManager.primary,
                    ),
                    hintText: "what do you search for?",
                    hintStyle: getRegularStyle(
                        color: ColorManager.primary, fontSize: FontSize.s16),
                  ),
                  onFieldSubmitted: _onSearchSubmitted,
                ),
              ),
              IconButton(
                onPressed: () {
                  print('Saved token: ${PrefsHandler.getToken()}');
                  Navigator.pushNamed(context, Routes.cartRoute);
                },
                icon: ImageIcon(
                  AssetImage(IconsAssets.icCart),
                  color: ColorManager.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
