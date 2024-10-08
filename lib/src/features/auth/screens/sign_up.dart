import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/auth/models/signup_request_model.dart';
import 'package:cryptonia/src/features/auth/providers/auth_provider.dart';
import 'package:cryptonia/src/features/auth/screens/create_password.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/utils/ui_utils.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _referralCodeController = TextEditingController();
  bool acceptTerms = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProv, _) {
        return Scaffold(
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
                          const SizedBox(height: 60),
                          Text(
                            'Start your journey.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppColors.kHintText),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Create Your Account',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 32),
                          CustomRoundedTextField(
                            label: 'Username',
                            hint: 'Enter your username',
                            controller: _usernameController,
                            keyboardType: TextInputType.name,
                          ),
                          const SizedBox(height: 16),
                          CustomRoundedTextField(
                            label: 'Email',
                            obscureText: true,
                            visibilityIcons: true,
                            controller: _emailController,
                            hint: 'Enter your email address',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),
                          CustomRoundedTextField(
                            obscureText: true,
                            visibilityIcons: true,
                            label: 'Referral Code',
                            controller: _referralCodeController,
                            keyboardType: TextInputType.emailAddress,
                            hint: 'Enter your referral code (optional)',
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Checkbox(
                                value: acceptTerms,
                                onChanged: (val) {
                                  if (val == null) return;

                                  setState(() {
                                    acceptTerms = val;
                                  });
                                },
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        'By creating an account, you agree to the ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(color: AppColors.kHintText),
                                    children: [
                                      TextSpan(
                                        text: 'Terms of Service',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                                color: AppColors.kPrimary,
                                                decoration:
                                                    TextDecoration.underline),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {},
                                      ),
                                      TextSpan(
                                        text: ' and ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                                color: AppColors.kHintText),
                                      ),
                                      TextSpan(
                                        text: 'Privacy Policy',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                                color: AppColors.kPrimary,
                                                decoration:
                                                    TextDecoration.underline),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {},
                                      ),
                                      TextSpan(
                                        text: ' of Cryptonia Ltd.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                                color: AppColors.kHintText),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  CustomButton(
                    onPressed: () {
                      if (acceptTerms == false) {
                        UiUtils.showErrorDialog(context,
                            description:
                                'Please accept the terms and conditions');
                        return;
                      }

                      if (_usernameController.text.trim().isEmpty) {
                        UiUtils.showErrorDialog(context,
                            description: 'Username is required');
                        return;
                      }

                      if (_emailController.text.trim().isEmpty) {
                        UiUtils.showErrorDialog(context,
                            description: 'Email is required');
                        return;
                      }

                      authProv.signupRequestModel = SignupRequestModel(
                        username: _usernameController.text.trim(),
                        email: _emailController.text.trim(),
                        password: '',
                        avatar: '',
                        referralCode: _referralCodeController.text.isEmpty
                            ? null
                            : _referralCodeController.text.trim(),
                      );

                      PageNavigation.pushPage(context, const CreatePassword());
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
