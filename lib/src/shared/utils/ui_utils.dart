import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UiUtils {
  static Widget loadingIndicator(BuildContext context,
      {Color color = AppColors.kPrimary, double size = 50.0}) {
    return SpinKitRing(color: color, size: size);
  }

  static void showLoadingIndicatorDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: loadingIndicator(context),
        );
      },
    );
  }

  static void showErrorDialog(
    BuildContext context, {
    String title = 'Error',
    required String description,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return ErrorDialog(title: title, description: description);
      },
    );
  }

  static showSnackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.kPrimary,
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
