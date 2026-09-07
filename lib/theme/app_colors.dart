import 'package:flutter/material.dart';

class AppColors {
  // Brand Primary & Accents
  static const Color primary = Color(0xFF00D09C); // 1Fi Emerald / Teal
  static const Color primaryDark = Color(0xFF00A87D);
  static const Color primaryLight = Color(0xFFE6FAF5);
  
  static const Color accent = Color(0xFF4361EE); // Electric Indigo
  static const Color accentLight = Color(0xFFEEF2FF);
  
  static const Color gold = Color(0xFFFFB703); // Premium Gold
  static const Color goldLight = Color(0xFFFFF8E7);
  
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Neutral Colors (Dark & Light)
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF1F5F9);

  static const Color textDark = Color(0xFF0F172A);
  static const Color textMedium = Color(0xFF475569);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color dividerLight = Color(0xFFF1F5F9);

  // Dark Theme Palette
  static const Color backgroundDark = Color(0xFF0B132B);
  static const Color cardDark = Color(0xFF141E3C);
  static const Color surfaceDark = Color(0xFF1E2B52);
  static const Color textLight = Color(0xFFF8FAFC);
  static const Color textLightMuted = Color(0xFF94A3B8);
  static const Color borderDark = Color(0xFF243360);

  // Gradient definitions
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF00D09C), Color(0xFF00B486)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradientDark = LinearGradient(
    colors: [Color(0xFF141E3C), Color(0xFF0E162D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF0B132B), Color(0xFF1C2D5A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFFFB703), Color(0xFFFB8500)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
