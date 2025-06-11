// splash_screen.dart

import 'package:ecommerce_app/core/prefrences/PrefsHandler.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
        context,
        PrefsHandler.getToken().isNotEmpty
            ? Routes.mainRoute
            : Routes.signInRoute,
      );
    });

    return Scaffold(
  body: SizedBox.expand(
    child: Image.asset(
      'assets/splash/logo.png',
      fit: BoxFit.cover,
    ),
  ),
);

  }
}
