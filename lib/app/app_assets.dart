class AppAssets {
  static const String iconsPath = "assets/icons/";
  static const String imagesPath = "assets/images/";

  /// SVG icons
  static String addIcon = "${iconsPath}add_icon.svg";

  /// App Images
  static String appLogo = "${imagesPath}app_logo_white.svg";

  /// example to how make assets aware of app brightness
  // static String get homeHeaderBg =>
  //     MyApp.isDark ? '${imagesPath}updateprofile.png' : "${imagesPath}background2.png";
}

class JsonAssets {
  static const String jsonPath = "assets/json";
  static const String splash = "$jsonPath/splash.json";
  static const String ai = "$jsonPath/ai.json";
  static const String loading = "$jsonPath/loading.json";
  static const String error = "$jsonPath/error.json";
  static const String empty = "$jsonPath/empty.json";
  static const String success = "$jsonPath/success.json";
}
