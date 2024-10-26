import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/otp_text_field.dart';
import 'package:flutter/material.dart';

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
                      CustomOtpTextField(controller: _otpController),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Didn't receive the code? "),
                          Flexible(
                            child: TextButton(
                              onPressed: () async {
                                // if (authProv.signupRequestModel?.email ==
                                //     null) {
                                //   return;
                                // }
                                //
                                // UiUtils.showLoadingIndicatorDialog(context);
                                //
                                // await authProv.sendOtp(
                                //     authProv.signupRequestModel!.email);
                                //
                                // PageNavigation.popPage(context);
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
                  PageNavigation.pushPage(
                      context, const DeletedAccountSuccessfully());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
