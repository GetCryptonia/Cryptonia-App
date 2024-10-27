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
          iconTheme: IconThemeData(color: AppColors.kTextColor),
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
          bodyLarge: TextStylesTheme.bodyLarge,
          bodyMedium: TextStylesTheme.bodyMedium,
          bodySmall: TextStylesTheme.bodySmall,
          labelLarge: TextStylesTheme.elevatedButton,
          labelMedium: TextStylesTheme.textField,
          labelSmall: TextStylesTheme.label,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.kContainerBg,
          selectedItemColor: AppColors.kPrimary,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.kTextField,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.kContainerBg,
        ),
        //     .apply(
        //   decorationColor: Colors.black,
        //   displayColor: Colors.black,
        //   bodyColor: Colors.black,
        // ),
      );
}

class AppColors {
  static const kPrimary = Color(0xffBB9534); //#BB9534

  static const kNavBarSelected = Color(0xff4F3F16); //#4F3F16

  static const kPrimaryGradient1 = Color(0xffAA882F); //#AA882F

  static const kPrimaryGradient2 = Color(0xff755E23); //#755E23

  static const kHintText = Color(0xff717171); //#717171

  static const kContainerBg = Color(0xff181818); //#181818

  static const kHistoryCategory = Color(0xff2C2C2C); //#2C2C2C

  static const kScaffold = Color(0xff0C0C0C); //#0C0C0C

  static const kTextField = Color(0xff1F1F1F); //#1F1F1F

  static const kGreenCheck = Color(0xff0F973D); //#0F973D

  static const kRedCross = Color(0xffD42620); //#D42620

  static const kYellowProcessing = Color(0xffF3A218); //#F3A218

  static const kTextColor = Color(0xffFFFFFF); //#FFFFFF

  static const kFadedText = Color(0xffCECECE); //#CECECE

  static const kProfileIcon = Color(0xffBBBBBB); //#BBBBBB
}
