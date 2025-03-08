import 'package:flutter/material.dart';
import 'package:front_balancelife/configs/theme/app_colors.dart';

class AppTheme {
  
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    brightness: Brightness.light,
    // fontFamily: 'Satoshi',
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryButtonColor,
          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          )
        )
    ),
  );
  
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    // fontFamily: 'Satoshi',
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryButtonColor,
          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          )
        )
    ),

  );
}