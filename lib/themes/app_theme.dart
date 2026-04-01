import 'package:flutter/material.dart';

//App theme with centralized colors, fonts, and styles for consistent design across the app

// Colors
class AppColors {
  AppColors._();

  static const primary = Color.fromARGB(255, 110, 117, 124);
  static const primaryLight = Color(0xFFE8F0FE);
  static const ratingOrange = Color.fromARGB(255, 241, 102, 22); // Colors.green[700]
  static const scaffoldBg = Color(0xFFF5F5F5);  // Colors.grey[100]
  static const cardBg = Colors.white;
  static const appBarBg = Colors.white;
  static const imageBg = Color(0xFFFAFAFA);      // Colors.grey[50]
  static const shadowColor = Colors.black12;
  static const closeButtonShadow = Colors.black26;
  static const iconGrey = Colors.grey;
  static const textDark = Colors.black87;
  static const textMuted = Color(0xFF757575);    // Colors.grey[600]
  static const textBody = Color(0xFF616161);     // Colors.grey[700]
  static const dividerColor = Colors.black12;
}

// Fonts
class AppFontSizes {
  AppFontSizes._();

  static const double xs = 10;
  static const double sm = 11;
  static const double body = 12;
  static const double bodyMd = 13;
  static const double md = 14;
  static const double lg = 16;
  static const double xl = 18;
  static const double xxl = 22;
  static const double appBarTitle = 22;
  static const double ratingBadge = 11;
  static const double ratingDetail = 13;
}

// Borders
class AppRadius {
  AppRadius._();

  static const double xs = 8.0;
  static const double sm = 10.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double badge = 12.0;
  static const double chip = 20.0;
  static const double circle = 100.0;
}

// Spacing
class AppSpacing {
  AppSpacing._();

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
}

// TextStyle
class AppTextStyles {
  AppTextStyles._();

  static const appBarTitle = TextStyle(
    color: AppColors.primary,
    fontWeight: FontWeight.bold,
    fontSize: AppFontSizes.appBarTitle,
  );

  static const sectionHeader = TextStyle(
    fontSize: AppFontSizes.xl,
    fontWeight: FontWeight.bold,
  );

  static const categoryLabel = TextStyle(
    fontSize: AppFontSizes.sm,
    fontWeight: FontWeight.w500,
  );

  static const productTitle = TextStyle(
    fontSize: AppFontSizes.body,
    fontWeight: FontWeight.w500,
  );

  static const productPrice = TextStyle(
    fontSize: AppFontSizes.md,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const detailTitle = TextStyle(
    fontSize: AppFontSizes.lg,
    fontWeight: FontWeight.bold,
  );

  static const detailPrice = TextStyle(
    fontSize: AppFontSizes.xxl,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const detailDescriptionHeader = TextStyle(
    fontSize: AppFontSizes.md,
    fontWeight: FontWeight.bold,
  );

  static const detailDescriptionBody = TextStyle(
    fontSize: AppFontSizes.bodyMd,
    color: AppColors.textBody,
    height: 1.5,
  );

  static const categoryChip = TextStyle(
    fontSize: AppFontSizes.xs,
    color: AppColors.primary,
    fontWeight: FontWeight.bold,
  );

  static const ratingBadge = TextStyle(
    color: Colors.white,
    fontSize: AppFontSizes.ratingBadge,
    fontWeight: FontWeight.bold,
  );

  static const ratingDetail = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: AppFontSizes.ratingDetail,
  );

  static const filterLabel = TextStyle(fontWeight: FontWeight.w500);

  static const filterTitle = TextStyle(
    fontSize: AppFontSizes.xl,
    fontWeight: FontWeight.bold,
  );

  static const addToCart = TextStyle(fontSize: AppFontSizes.lg);

  static const searchHint = TextStyle(color: AppColors.iconGrey);
}

// App Theme
class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.scaffoldBg,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.appBarBg,
          elevation: 1,
          iconTheme: IconThemeData(color: AppColors.textDark),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.xs),
            ),
          ),
        ),
        sliderTheme: const SliderThemeData(
          activeTrackColor: AppColors.primary,
          thumbColor: AppColors.primary,
        ),
      );
}
