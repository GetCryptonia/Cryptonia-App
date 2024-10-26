import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/profile/screens/edit_profile/verify_changed_email.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({super.key});

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _newEmail = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Change Email Address'),
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
                    'Enter your new email address',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  CustomRoundedTextField(
                    controller: _email,
                    label: 'Old email',
                    hint: 'Current email address',
                  ),
                  const SizedBox(height: 16),
                  CustomRoundedTextField(
                    controller: _newEmail,
                    label: 'New email',
                    hint: 'New email address',
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
              text: 'Next',
              onPressed: () {
                PageNavigation.pushPage(context, const VerifyChangedEmail());
              },
            )
          ],
        ),
      ),
    );
  }
}
