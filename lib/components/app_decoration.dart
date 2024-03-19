import 'package:crops_ai/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppDecorations {
  AppDecorations._(); // ! Private constructor to prevent instantiation

  static final inputDecorationLight = InputDecoration(
    filled: true,
    fillColor: AppColors.transparent,
    contentPadding:
        const EdgeInsets.only(left: 8, top: 13, bottom: 13, right: 8),
    isDense: true,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1, color: AppColors.primaryColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(width: 1, color: AppColors.primaryColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.error),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
