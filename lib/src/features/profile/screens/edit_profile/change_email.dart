import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/auth/providers/auth_provider.dart';
import 'package:cryptonia/src/features/profile/models/edit_email_model.dart';
import 'package:cryptonia/src/features/profile/providers/profile_provider.dart';
import 'package:cryptonia/src/features/profile/screens/edit_profile/verify_changed_email.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/utils/ui_utils.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Consumer<ProfileProvider>(
      builder: (context, profileProv, _) {
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
                  onPressed: () async {
                    if (_email.text.isEmpty) {
                      UiUtils.showSnackBar(context, 'Enter your old email');
                      return;
                    }

                    if (_newEmail.text.isEmpty) {
                      UiUtils.showSnackBar(context, 'Enter your new email');
                      return;
                    }

                    if (_password.text.isEmpty) {
                      UiUtils.showSnackBar(context, 'Enter your password');
                      return;
                    }

                    profileProv.editEmail = EditEmailModel(
                      oldEmail: _email.text,
                      newEmail: _newEmail.text,
                      password: _password.text,
                    );

                    UiUtils.showLoadingIndicatorDialog(context);

                    final res =
                        await context.read<AuthProvider>().sendOtp(_email.text);

                    PageNavigation.popPage(context);

                    UiUtils.displayResponse(context, res);

                    if (res.status == Status.error) return;

                    PageNavigation.pushPage(
                        context, const VerifyChangedEmail());
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
