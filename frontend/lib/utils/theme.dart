import 'package:flutter/material.dart';

class AppTheme {
  // Primary Colors
  static const Color primaryOrange = Color(0xFFFF8C42);
  static const Color darkOrange = Color(0xFFFF6B1A);
  static const Color lightOrange = Color(0xFFFFAA6B);
  
  // Secondary Colors
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color cardBackground = Colors.white;
  static const Color lightGray = Color(0xFFF1F3F5);
  static const Color mediumGray = Color(0xFFE9ECEF);
  static const Color darkGray = Color(0xFF6C757D);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212529);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textLight = Color(0xFFADB5BD);
  
  // Status Colors
  static const Color success = Color(0xFF51CF66);
  static const Color warning = Color(0xFFFFD43B);
  static const Color error = Color(0xFFFF6B6B);
  static const Color info = Color(0xFF4DABF7);
  
  // Score Colors
  static const Color scoreExcellent = Color(0xFF51CF66);
  static const Color scoreGood = Color(0xFF94D82D);
  static const Color scoreAverage = Color(0xFFFFD43B);
  static const Color scorePoor = Color(0xFFFF8787);
  
  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [darkOrange, primaryOrange],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Shadows
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];
  
  static List<BoxShadow> buttonShadow = [
    BoxShadow(
      color: primaryOrange.withOpacity(0.3),
      blurRadius: 12,
      offset: const Offset(0, 6),
    ),
  ];
  
  // Border Radius
  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(16));
  static const BorderRadius buttonRadius = BorderRadius.all(Radius.circular(12));
  static const BorderRadius chipRadius = BorderRadius.all(Radius.circular(20));
  
  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingSM = 8.0;
  static const double spacingMD = 16.0;
  static const double spacingLG = 24.0;
  static const double spacingXL = 32.0;
  
  // Get score color based on value
  static Color getScoreColor(int score) {
    if (score >= 90) return scoreExcellent;
    if (score >= 75) return scoreGood;
    if (score >= 60) return scoreAverage;
    return scorePoor;
  }
  
  // Get trend color
  static Color getTrendColor(double percentage) {
    return percentage >= 0 ? success : error;
  }
}
