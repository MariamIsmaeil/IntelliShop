import 'package:ecommerce_app/core/DI/DI.dart';
import 'package:ecommerce_app/core/network/api_manager.dart';
import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/features/auth/sign_up_screen/data/models/SignUpResponse/SignUpReponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/bloc_observer.dart';
import 'core/prefrences/PrefsHandler.dart';
import 'core/routes_manager/route_generator.dart';
import 'features/products_screen/presentation/manager/products_cubit.dart';
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  
  await PrefsHandler.init();

  ApiManager.init();
  await PrefsHandler.setToken("test_token_123");
  await PrefsHandler.getName();
await PrefsHandler.getEmail();
  Bloc.observer = MyBlocObserver();

  runApp(BlocProvider(
      create: (context) => getIt<ProductsCubit>(),
      child: const MainApp()));
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("token : ${PrefsHandler.getToken()}");
    return ScreenUtilInit(
      designSize: Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        navigatorObservers: [routeObserver],
        home:child ,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        // initialRoute: PrefsHandler.getToken().isNotEmpty
        //     ?Routes.mainRoute
        //     :Routes.signInRoute,
        initialRoute: Routes.splashRoute,
      ),
    );
  }
}
