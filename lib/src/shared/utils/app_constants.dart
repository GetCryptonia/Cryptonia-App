import 'package:flutter/material.dart';

class AppConstants {
  static String get baseUrl => 'https://cryptonia-backend.onrender.com/api/v1/';

  static String get palmPayPic =>
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6dcuBlGF43-S2sxFusqq2R9Gtg9CJPOrzRQ&s';

  static EdgeInsetsGeometry get kScaffoldPadding => const EdgeInsets.all(16);

  static void setTextFieldValue({
    required TextEditingController controller,
    required String text,
  }) {
    String updatedText = text;

    controller.value = controller.value.copyWith(
      text: updatedText,
      selection: TextSelection.fromPosition(
        TextPosition(offset: updatedText.length),
      ),
    );
  }
}
