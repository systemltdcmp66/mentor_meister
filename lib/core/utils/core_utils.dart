import 'package:flutter/material.dart';
import 'package:mentormeister/core/utils/custom_color.dart';

class CoreUtils {
  const CoreUtils._();

  static void showSnackar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          backgroundColor: CustomColor.redColor,
          behavior: SnackBarBehavior.floating,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: CustomColor.redColor,
            ),
          ),
          margin: const EdgeInsets.all(
            20,
          ).copyWith(top: 0),
        ),
      );
  }
}
