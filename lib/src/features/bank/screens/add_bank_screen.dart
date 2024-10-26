import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class AddBankScreen extends StatefulWidget {
  const AddBankScreen({super.key});

  @override
  State<AddBankScreen> createState() => _AddBankScreenState();
}

class _AddBankScreenState extends State<AddBankScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Account'),
        backgroundColor: AppColors.kContainerBg,
      ),
      body: Padding(
        padding: AppConstants.kScaffoldPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                children: [
                  const Text('Add your bank account for completing exchanges'),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.info_outline,
                          color: AppColors.kHintText, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Only personal accounts are allowed',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.kHintText),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomRoundedTextField(
                    label: 'Select Bank',
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.kHintText,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomRoundedTextField(
                    label: 'Enter Account Number',
                  ),
                ],
              ),
            ),
            CustomButton(
              text: 'Add Bank Account',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
