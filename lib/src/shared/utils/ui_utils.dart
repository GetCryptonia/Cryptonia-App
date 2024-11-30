import 'package:cryptonia/src/core/network/api_response.dart';
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

  static void displayResponse(BuildContext context, ApiResponse res) {
    switch (res.status) {
      case Status.success:
        showSnackBar(context, res.errorMessage ?? res.message);
        break;
      case Status.error:
        showErrorDialog(context, description: res.errorMessage ?? res.message);
        break;
    }
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

  static showSnackBar(BuildContext context, String text,
      {Color color = AppColors.kPrimary}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
