import 'package:ecommerce_app/core/DI/DI.dart';
import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/features/auth/sign_in_screen/presentation/pages/sign_in_screen.dart';
import 'package:ecommerce_app/features/auth/sign_up_screen/presentation/pages/sign_up_screen.dart';
import 'package:ecommerce_app/features/main_layout/main_layout.dart';
import 'package:ecommerce_app/features/product_details/presentation/screen/product_details.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/ProductEntity.dart';
import 'package:ecommerce_app/features/products_screen/presentation/screens/products_screen.dart';
import 'package:ecommerce_app/features/search/presentation/manger/search_cubit.dart';
import 'package:ecommerce_app/features/search/presentation/recommendation_screen.dart';
import 'package:ecommerce_app/features/search/presentation/search_screen.dart';
import 'package:ecommerce_app/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/main_layout/home/domain/entities/CategoriesEntity/CategoryEntity.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
  return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.searchRoute:
        final query = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SearchCubit>(),
            child: SearchScreen(initialQuery: query),
          ),
        );

      case Routes.recommendationsRoute:
        return MaterialPageRoute(builder: (_) => const RecommendationScreen());
      case Routes.cartRoute:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainLayout());

      case Routes.productsScreenRoute:
        {
          CategoryEntity? categoryEntity = settings.arguments as CategoryEntity;
          return MaterialPageRoute(
              builder: (_) => ProductsScreen(
                    categoryEntity: categoryEntity,
                  ));
        }

      case Routes.productDetails:
        final product = settings.arguments as ProductEntity;
        return MaterialPageRoute(
          builder: (_) => ProductDetails(product: product),
        );

      case Routes.signInRoute:
        return MaterialPageRoute(builder: (_) => const SignInScreen());

      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('No Route Found'),
        ),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}
