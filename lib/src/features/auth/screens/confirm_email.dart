import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/auth/screens/new_password.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/otp_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConfirmEmail extends StatefulWidget {
  const ConfirmEmail({super.key});

  @override
  State<ConfirmEmail> createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {
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
                        'Confirm Email',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter the 6-digit code sent to your email',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.kHintText),
                      ),
                      Text(
                        'spielereinzig@gmail.com',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 32),
                      const CustomOtpTextField(),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Didn't receive the code? "),
                          Flexible(
                            child: TextButton(
                              onPressed: () {},
                              child: const Text('Resend in 30s'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                onPressed: () =>
                    PageNavigation.pushPage(context, const NewPassword()),
                text: 'Verify',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
