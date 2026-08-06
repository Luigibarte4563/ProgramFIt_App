import 'package:flutter/material.dart';

/// Soft Neo-Brutalist color palette migrated from the React/Tailwind design
/// system (`ProgramFit_Web`).
abstract final class AppColors {
  static const bgMain = Color(0xFFF7EBE1);
  static const brandPrimary = Color(0xFF2F8CE5);
  static const shadowHard = Color(0xFF1D3557);
  static const textPrimary = Color(0xFF000000);
  static const textSecondary = Color(0xFF0D1B2A);
  static const bgCard = Color(0xFFFFFFFF);
  static const borderUi = Color(0xFFC5C5C5);
  static const danger = Color(0xFFEA4335);
  static const success = Color(0xFF2E7D32);
  static const warningText = Color(0xFF78350F);
  static const warningBg = Color(0xFFFFFBEB);
}

/// Neo-brutalist hard, unblurred offset shadow.
List<BoxShadow> neoShadow({
  double x = 6,
  double y = 6,
  Color color = AppColors.shadowHard,
}) {
  return [
    BoxShadow(color: color, offset: Offset(x, y), blurRadius: 0),
  ];
}

ThemeData buildAppTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.brandPrimary),
    scaffoldBackgroundColor: AppColors.bgMain,
  );

  return base.copyWith(
    textTheme: base.textTheme.apply(bodyColor: AppColors.textSecondary),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.brandPrimary,
    ),
    splashFactory: InkSparkle.splashFactory,
  );
}
