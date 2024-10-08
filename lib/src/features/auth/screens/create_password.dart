import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/auth/providers/auth_provider.dart';
import 'package:cryptonia/src/features/auth/screens/select_avatar.dart';
import 'package:cryptonia/src/features/auth/widgets/password_validation_card.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/utils/string_validation.dart';
import 'package:cryptonia/src/shared/utils/ui_utils.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProv, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: IconButton(
              onPressed: () => PageNavigation.popPage(context),
              icon: SvgPicture.asset(
                  'assets/svgs/onboarding/arrow-left-line.svg'),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: AppConstants.kScaffoldPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create New Password',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 20),
                          CustomRoundedTextField(
                            controller: _password,
                            label: 'Password',
                            hint: 'Enter your password',
                            obscureText: true,
                            visibilityIcons: true,
                            onChanged: (val) => setState(() {}),
                          ),
                          const SizedBox(height: 20),
                          CustomRoundedTextField(
                            controller: _confirmPassword,
                            label: 'Confirm Password',
                            hint: 'Re-enter your password',
                            obscureText: true,
                            visibilityIcons: true,
                            onChanged: (val) => setState(() {}),
                          ),
                          const SizedBox(height: 20),
                          PasswordValidationCard(password: _password.text),
                        ],
                      ),
                    ),
                  ),
                  CustomButton(
                    onPressed: () async {
                      if (_password.text.length < 8) {
                        UiUtils.showErrorDialog(context,
                            description:
                                'Password must be at least 8 characters long');
                        return;
                      }

                      if (!StringValidation.containsSpecialCharacter(
                          _password.text)) {
                        UiUtils.showErrorDialog(context,
                            description:
                                'Password must contain at least one special character');
                        return;
                      }

                      if (!StringValidation.containsNumber(_password.text)) {
                        UiUtils.showErrorDialog(context,
                            description:
                                'Password must contain at least one number');
                        return;
                      }

                      if (!StringValidation.containsLowerCase(_password.text)) {
                        UiUtils.showErrorDialog(context,
                            description:
                                'Password must contain at least one lowercase character');
                        return;
                      }

                      if (!StringValidation.containsUpperCase(_password.text)) {
                        UiUtils.showErrorDialog(context,
                            description:
                                'Password must contain at least one uppercase character');
                        return;
                      }

                      if (_password.text != _confirmPassword.text) {
                        UiUtils.showErrorDialog(context,
                            description: 'Passwords do not match');
                        return;
                      }

                      authProv.signupRequestModel?.password = _password.text;

                      PageNavigation.pushPage(context, const SelectAvatar());
                    },
                    text: 'Continue',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
