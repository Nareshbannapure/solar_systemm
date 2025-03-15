
import 'package:flutter/material.dart';
import 'package:solar_system/screens/detail/detail_screen.dart';
import 'package:solar_system/screens/favorite/fav_screen.dart';
import 'package:solar_system/screens/home/home_screen.dart';
import 'package:solar_system/screens/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String detail = '/detail';
  static const String favorite = '/favorite';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    home: (context) => const HomeScreen(),
    detail: (context) => const DetailScreen(),
    favorite: (context) => const FavoriteScreen(),
  };
}
