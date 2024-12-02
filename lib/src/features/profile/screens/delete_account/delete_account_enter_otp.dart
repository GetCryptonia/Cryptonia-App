import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/auth/providers/auth_provider.dart';
import 'package:cryptonia/src/features/profile/providers/profile_provider.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/utils/ui_utils.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/otp_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'deleted_account_successfully.dart';

class DeleteAccountEnterOtp extends StatefulWidget {
  const DeleteAccountEnterOtp({super.key});

  @override
  State<DeleteAccountEnterOtp> createState() => _DeleteAccountEnterOtpState();
}

class _DeleteAccountEnterOtpState extends State<DeleteAccountEnterOtp> {
  final TextEditingController _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProv, _) {
        return Consumer<ProfileProvider>(
          builder: (context, profileProv, _) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                automaticallyImplyLeading: true,
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
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
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
                                profileProv.profile?.email ?? '',
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
                                        if (profileProv.profile?.email ==
                                            null) {
                                          return;
                                        }

                                        UiUtils.showLoadingIndicatorDialog(
                                            context);

                                        await authProv.sendOtp(
                                            profileProv.profile!.email);

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
                        text: 'Complete Deletion',
                        color: AppColors.kRedCross,
                        onPressed: () async {
                          if (_otpController.text.length != 6) {
                            UiUtils.showSnackBar(context, 'Invalid OTP');
                            return;
                          }

                          UiUtils.showLoadingIndicatorDialog(context);

                          final res = await profileProv
                              .deleteAccount(_otpController.text);

                          PageNavigation.popPage(context);

                          UiUtils.displayResponse(context, res);

                          if (res.status == Status.error) return;

                          PageNavigation.pushPage(
                              context, const DeletedAccountSuccessfully());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
