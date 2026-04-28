import 'package:flutter/material.dart';

class AppColors {
  // 🔵 Primary Colors
  static const Color primary = Color(0xFF1E3A8A); // Deep Blue
  static const Color secondary = Color(0xFF14B8A6); // Teal / Cyan
  static const Color accent = Color(0xFFF97316); // Orange

  // ⚪ Background Colors
  static const Color backgroundLight = Color(0xFFF9FAFB);
  static const Color backgroundDark = Color(0xFF0F172A);

  // 📝 Text Colors
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textLight = Color(0xFFFFFFFF);

  // ✅ Status Colors
  static const Color success = Color(0xFF22C55E); // Green
  static const Color error = Color(0xFFEF4444); // Red
  static const Color warning = Color(0xFFEAB308); // Yellow

  // 🔲 UI Elements
  static const Color border = Color(0xFFE5E7EB);
  static const Color card = Color(0xFFFFFFFF);
  static const Color shadow = Color(0x1A000000); // Black with opacity

  // 🚀 Buttons
  static const Color buttonPrimary = primary;
  static const Color buttonSecondary = secondary;
  static const Color buttonDisabled = Color(0xFF9CA3AF);

  // 🔍 Scanner UI (important for your project)
  static const Color scanOverlay = Color(0x80000000); // semi-transparent black
  static const Color scanFrame = accent; // highlight scan area
}
