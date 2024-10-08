import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/auth/screens/create_password.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
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
                      const CustomRoundedTextField(
                        label: 'Username',
                        hint: 'Enter your username',
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 16),
                      const CustomRoundedTextField(
                        label: 'Email',
                        hint: 'Enter your email address',
                        obscureText: true,
                        visibilityIcons: true,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      const CustomRoundedTextField(
                        label: 'Referral Code',
                        hint: 'Enter your referral code (optional)',
                        obscureText: true,
                        visibilityIcons: true,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Checkbox(
                            value: true,
                            onChanged: (val) {},
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
                                        ?.copyWith(color: AppColors.kHintText),
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
                                        ?.copyWith(color: AppColors.kHintText),
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
                onPressed: () =>
                    PageNavigation.pushPage(context, const CreatePassword()),
                text: 'Continue',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
