import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/string_validation.dart';
import 'package:flutter/material.dart';

class PasswordValidationCard extends StatelessWidget {
  final String password;
  const PasswordValidationCard({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    Widget validationItem({required String title, required bool isValid}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Icon(
              isValid ? Icons.check_circle : Icons.cancel,
              size: 18,
              color: isValid ? AppColors.kGreenCheck : AppColors.kRedCross,
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.kHintText),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kTextField,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Your password should have'),
          const SizedBox(height: 8),
          validationItem(
            title: 'At least 1 uppercase letter',
            isValid: StringValidation.containsUpperCase(password),
          ),
          validationItem(
            title: 'At least 8 letters',
            isValid: password.length >= 8,
          ),
          validationItem(
            title: 'At least 1 Number',
            isValid: StringValidation.containsNumber(password),
          ),
          validationItem(
            title: 'At least 1 special character (1#^&*())&%#)',
            isValid: StringValidation.containsSpecialCharacter(password),
          ),
        ],
      ),
    );
  }
}
