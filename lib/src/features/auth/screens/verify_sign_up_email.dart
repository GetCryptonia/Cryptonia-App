import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/auth/providers/auth_provider.dart';
import 'package:cryptonia/src/features/auth/screens/account_creation_successful.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/utils/ui_utils.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/otp_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class VerifySignUpEmail extends StatefulWidget {
  const VerifySignUpEmail({super.key});

  @override
  State<VerifySignUpEmail> createState() => _VerifySignUpEmailState();
}

class _VerifySignUpEmailState extends State<VerifySignUpEmail> {
  final TextEditingController _otpController = TextEditingController();
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
                            'Verify Email',
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
                            authProv.signupRequestModel?.email ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 32),
                          CustomOtpTextField(controller: _otpController),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("Didn't receive the code? "),
                              Flexible(
                                child: TextButton(
                                  onPressed: () async {
                                    if (authProv.signupRequestModel?.email ==
                                        null) {
                                      return;
                                    }

                                    UiUtils.showLoadingIndicatorDialog(context);

                                    await authProv.sendOtp(
                                        authProv.signupRequestModel!.email);

                                    PageNavigation.popPage(context);
                                  },
                                  child: const Text('Resend otp'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomButton(
                    onPressed: () async {
                      UiUtils.showLoadingIndicatorDialog(context);

                      final res = await authProv.verifyEmail(
                          context, _otpController.text);

                      PageNavigation.popPage(context);

                      if (res.status == Status.error) {
                        UiUtils.showErrorDialog(context,
                            description: res.message);
                        return;
                      }

                      PageNavigation.pushPage(
                          context, const AccountCreationSuccessful());
                    },
                    text: 'Verify',
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
