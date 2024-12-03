import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/kyc/provider/kyc_provider.dart';
import 'package:cryptonia/src/features/kyc/screens/bvn/bvn_verified.dart';
import 'package:cryptonia/src/features/kyc/utils/enums/kyc_type.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/utils/ui_utils.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/otp_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class VerifyBvnOtp extends StatefulWidget {
  const VerifyBvnOtp({super.key});

  @override
  State<VerifyBvnOtp> createState() => _VerifyBvnOtpState();
}

class _VerifyBvnOtpState extends State<VerifyBvnOtp> {
  final TextEditingController _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<KycProvider>(
      builder: (context, kycProv, _) {
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
                            'Verify Otp',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Enter the 6-digit code sent to the '
                            'phone number attached to your bvn',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppColors.kHintText),
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
                                    if (kycProv.number == null ||
                                        kycProv.number!.isEmpty) {
                                      UiUtils.showErrorDialog(context,
                                          description:
                                              'Please enter the bvn number');
                                      return;
                                    }

                                    UiUtils.showLoadingIndicatorDialog(context);

                                    final res = await kycProv.sendOtp(
                                        number: kycProv.number!,
                                        type: KycType.bvn);

                                    PageNavigation.popPage(context);

                                    UiUtils.displayResponse(context, res);
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
                      if (_otpController.text.isEmpty) {
                        UiUtils.showErrorDialog(context,
                            description: 'Please enter the otp');
                        return;
                      }

                      UiUtils.showLoadingIndicatorDialog(context);

                      final res = await kycProv.verifyOtp(
                          otp: _otpController.text, type: KycType.bvn);

                      PageNavigation.popPage(context);

                      UiUtils.displayResponse(context, res);

                      if (res.status != Status.success) return;

                      PageNavigation.pushPage(context, const BvnVerified());
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
