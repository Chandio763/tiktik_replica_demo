import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'app_constants.dart';
import 'app_textstyles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    fontFamily: AppConstants.appFont,
    // colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      onSurface: AppColors.black,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.white,
    ),
    appBarTheme:  AppBarTheme(
      color: AppColors.white,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: AppTextStyles.bold22,
      scrolledUnderElevation: 0,
    ),
    scaffoldBackgroundColor: AppColors.scaffoldBG,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        backgroundColor: AppColors.primary,
        textStyle: AppTextStyles.bold14.copyWith(color: AppColors.white),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
    ),

    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
    ),
    listTileTheme: ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      minVerticalPadding: 0,
      dense: true, // makes it visually smaller
    ),
  );
}
