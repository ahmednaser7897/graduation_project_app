import 'dart:io';

import 'package:flutter/material.dart';

import '../ui/componnents/show_photos.dart';
import '../ui/home/home.dart';
import '../ui/splashscreen.dart';

class AppRouter {
  static const String homeScreen = "homeScreen";
  static const String showPhotosScreen = "showPhotosScreen";
  static const String splashScreen = "splashScreen";
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case showPhotosScreen:
        final List<File> photos = settings.arguments as List<File>;
        return MaterialPageRoute(
            builder: (_) => ShowPhotosScreen(
                  photos: photos,
                ));
      /*
      case otpScreen:
        final request = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => OtpScreen(request: request));
      */
      default:
        return MaterialPageRoute(
            builder: (_) => const Center(
                  child: Text("Page Not Found"),
                ));
    }
  }
}
