import 'package:cryptonia/src/features/auth/widgets/password_validation_card.dart';
import 'package:cryptonia/src/shared/theming/page_navigation.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () => PageNavigation.popPage(context),
          icon: SvgPicture.asset('assets/svgs/onboarding/arrow-left-line.svg'),
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
                      const CustomRoundedTextField(
                        label: 'Password',
                        hint: 'Enter your password',
                        obscureText: true,
                        visibilityIcons: true,
                      ),
                      const SizedBox(height: 20),
                      const CustomRoundedTextField(
                        label: 'Confirm Password',
                        hint: 'Re-enter your password',
                        obscureText: true,
                        visibilityIcons: true,
                      ),
                      const SizedBox(height: 20),
                      const PasswordValidationCard(password: 'Password'),
                    ],
                  ),
                ),
              ),
              CustomButton(
                onPressed: () {},
                text: 'Continue',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
