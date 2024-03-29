import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project/app/text_style.dart';

import 'app_colors.dart';
import 'extensions.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme) {
    return ThemeData(
        fontFamily: AppTextStyle.mainArFont,
        primarySwatch: AppColors.mainColor.getMaterialColor(),
        appBarTheme: const AppBarTheme(
          // titleSpacing: 20,
          backgroundColor: Colors.transparent,
          elevation: 0,
          // to control status bar color default = true
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.statusBarColorTransparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
        ),
        // primaryColor: isDarkTheme ? Colors.black : Colors.white,
        //
        backgroundColor: AppColors.appBackground,
        scaffoldBackgroundColor: AppColors.appBackground,
        //
        // indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
        // buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
        //
        // hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),
        //
        // highlightColor: isDarkTheme ? Color(0xff372901) : Color(0x640b9490),
        // hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
        //
        // focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
        // disabledColor: Colors.grey,
        // // textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
        // cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
        // canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
        // // buttonTheme: Theme.of(context).buttonTheme.copyWith(
        // //     colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
        // appBarTheme: AppBarTheme(
        //   elevation: 0.0,
        // ),
        brightness: isDarkTheme ? Brightness.dark : Brightness.light);
  }
}
