import 'package:flutter/material.dart';
import 'package:news_connect/src/common/resources/strings_manager.dart';
import 'package:news_connect/src/features/authentication/presentation/screens/login_page.dart';
import 'package:news_connect/src/features/authentication/presentation/screens/registration_page.dart';
import 'package:news_connect/src/features/main/presentation/screens/main_page.dart';

class Routes {
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String homeRoute = "/homePage";
  static const String mainRoute = "/mainRoute";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainPage());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegistrationPage());
      case Routes.forgotPasswordRoute:
      //  return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      case Routes.homeRoute:
      //   return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(child: Text(AppStrings.noRouteFound)),
      ),
    );
  }
}
