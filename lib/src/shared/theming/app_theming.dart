import 'package:cryptonia/src/shared/theming/custom_text_styles.dart';
import 'package:flutter/material.dart';

class AppTheming {
  static ThemeData get darkThemeData => ThemeData.dark().copyWith(
      primaryColor: AppColors.kPrimary,
      scaffoldBackgroundColor: AppColors.kScaffold,
      iconTheme: const IconThemeData(color: Colors.white, size: 25),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.kScaffold,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.kTextField),
        titleTextStyle: TextStylesTheme.bodyMedium,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              const WidgetStatePropertyAll<Color>(AppColors.kPrimary),
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(horizontal: 37.5, vertical: 18.5)),
          textStyle: WidgetStatePropertyAll<TextStyle>(
            TextStylesTheme.textButton.copyWith(color: AppColors.kTextColor),
          ),
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
              EdgeInsets.all(0)),
          textStyle: WidgetStatePropertyAll<TextStyle>(
            TextStylesTheme.textButton.copyWith(color: AppColors.kPrimary),
          ),
        ),
      ),
      colorScheme: const ColorScheme.dark(primary: AppColors.kPrimary),
      textTheme: const TextTheme(
        headlineMedium: TextStylesTheme.headingMedium,
        headlineSmall: TextStylesTheme.headingSmall,
        bodyMedium: TextStylesTheme.bodyMedium,
        bodySmall: TextStylesTheme.bodySmall,
        labelLarge: TextStylesTheme.elevatedButton,
        labelMedium: TextStylesTheme.textField,
        labelSmall: TextStylesTheme.label,
      )
      //     .apply(
      //   decorationColor: Colors.black,
      //   displayColor: Colors.black,
      //   bodyColor: Colors.black,
      // ),
      );
}

class AppColors {
  static const kPrimary = Color(0xffBB9534); //#BB9534

  static const kHintText = Color(0xff717171); //#717171

  static const kScaffold = Color(0xff0C0C0C); //#0C0C0C

  static const kTextField = Color(0xff1F1F1F); //#1F1F1F

  static const kGreenCheck = Color(0xff0F973D); //#0F973D

  static const kRedCross = Color(0xffD42620); //#D42620

  static const kTextColor = Color(0xffFFFFFF); //#FFFFFF
}
