import 'package:flutter/material.dart';
import 'package:prueba_tecnica_dashfleet/app/ui/pages/home/home_page.dart';
import 'package:prueba_tecnica_dashfleet/app/ui/pages/login/login_page.dart';
import 'package:prueba_tecnica_dashfleet/app/ui/pages/recover/recover_password_screen.dart';
import 'package:prueba_tecnica_dashfleet/app/ui/pages/roads/roads_page.dart';
import 'package:prueba_tecnica_dashfleet/app/ui/pages/splash/splash_page.dart';

abstract class AppRoutes {
  static const SPLASH = '/splashScreen';
  static const LOGIN = '/loginScreen';
  static const HOME = '/homeScreen';
  static const ROADS = '/roadsScreen';
  static const RECOVER = '/recoverScreen';
}

class AppRouting {
  static PageRoute<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splashScreen':
        return _fadeRoute(SplashScreen(), settings);
      case '/loginScreen':
        return _fadeRoute(LoginScreen(), settings);
      case '/homeScreen':
        return _fadeRoute(HomeScreen(), settings);
      case '/roadsScreen':
        return _fadeRoute(RoadsScreen(), settings);
      case '/recoverScreen':
        return _fadeRoute(RecoverPasswordScreen(), settings);
      default:
        return _fadeRoute(LoginScreen(), settings);
    }
  }

  static PageRoute _fadeRoute(Widget view, RouteSettings settings) {
    return PageRouteBuilder(
        pageBuilder: (_, animation1, animation2) => view,
        settings: settings,
        transitionDuration: const Duration(milliseconds: 10),
        transitionsBuilder: (_, animation1, animation2, _____) =>
            FadeTransition(
              opacity: animation1,
              child: view,
            ));
  }
}
