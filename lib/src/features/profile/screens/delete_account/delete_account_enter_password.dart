import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import 'delete_account_enter_otp.dart';

class DeleteAccountEnterPassword extends StatefulWidget {
  const DeleteAccountEnterPassword({super.key});

  @override
  State<DeleteAccountEnterPassword> createState() =>
      _DeleteAccountEnterPasswordState();
}

class _DeleteAccountEnterPasswordState
    extends State<DeleteAccountEnterPassword> {
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Delete Account'),
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
                  Text(
                    'Your Account will be permanently deleted!.\n'
                    'To continue Confirm your Account Password.',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  CustomRoundedTextField(
                    controller: _password,
                    label: 'Password',
                    hint: 'Your password',
                  ),
                ],
              ),
            ),
            CustomButton(
              text: 'Continue',
              color: AppColors.kRedCross,
              onPressed: () {
                PageNavigation.pushPage(context, const DeleteAccountEnterOtp());
              },
            )
          ],
        ),
      ),
    );
  }
}