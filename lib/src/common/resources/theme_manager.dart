import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_connect/src/common/resources/color_manager.dart';
import 'package:news_connect/src/common/resources/font_manager.dart';
import 'package:news_connect/src/common/resources/style_manager.dart';
import 'package:news_connect/src/common/resources/value_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    useMaterial3: false,

    /// main colors of the app
    primaryColor: AppColors.greenWithOpacity40,
    primaryColorLight: AppColors.blueBrandOpacity70,
    disabledColor: AppColors.accentBlue,

    /// ripple color
    splashColor: AppColors.blueBrandOpacity70,

    /// will be used incase of disabled button for example
    hintColor: AppColors.accentBlue,

    /// card view theme
    cardTheme: const CardTheme(
        color: AppColors.white,
        shadowColor: AppColors.grey,
        elevation: AppSize.s4),

    ///App bar theme
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(
        color: AppColors.black, // Set the color of the back arrow here
      ),
      backgroundColor: AppColors.white,
      elevation: AppSize.s1,
      shadowColor: AppColors.blackPrimary.withOpacity(0.08),
      titleTextStyle: getSemiBoldStyle(
        color: AppColors.black,
        fontSize: 16.sp,
      ),
    ),

    /// Text theme
    textTheme: TextTheme(
      headlineLarge: getBoldStyle(
        color: AppColors.blackPrimary,
        fontSize: FontSize.s24,
      ),
      headlineMedium: getBoldStyle(
        color: AppColors.blackPrimary,
        fontSize: FontSize.s22,
      ),
      headlineSmall: getSemiBoldStyle(
        color: AppColors.blackPrimary,
        fontSize: FontSize.s20,
      ),
      bodyLarge: getMediumStyle(
        color: AppColors.blackPrimary,
        fontSize: FontSize.s20,
      ),
      bodyMedium: getMediumStyle(
        color: AppColors.blackPrimary,
        fontSize: FontSize.s18,
      ),
      bodySmall: getRegularStyle(
        color: AppColors.blackPrimary,
        fontSize: FontSize.s16,
      ),
    ),
  );
}
