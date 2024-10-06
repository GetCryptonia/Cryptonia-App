import 'package:flutter/cupertino.dart';

class AppConstants {
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
