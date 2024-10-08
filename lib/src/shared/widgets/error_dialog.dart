import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String description;
  const ErrorDialog({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.kTextField,
      icon: const Icon(Icons.error, color: AppColors.kPrimary, size: 45),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.w900),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Divider(color: Colors.white30),
          const SizedBox(height: 10),
          CustomButton(
            text: 'OK',
            padding: const EdgeInsets.symmetric(vertical: 10),
            onPressed: () => PageNavigation.popPage(context),
          )
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
