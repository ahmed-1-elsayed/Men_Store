import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {
  AppStyles._();

  // Login title
  static const TextStyle title = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  // User name
  static const TextStyle userName = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.grey,
  );

  // Labels (Email, Password)
  static const TextStyle label = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  // Hint inside TextField
  static const TextStyle hint = TextStyle(
    fontSize: 14,
    color: AppColors.grey,
  );

  // Button text
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  // Bottom text
  static const TextStyle footer = TextStyle(
    fontSize: 16,
    color: AppColors.grey,
    fontWeight: FontWeight.w400,
  );

  // Join / Login link
  static const TextStyle link = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );
}