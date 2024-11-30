import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/kyc/provider/kyc_provider.dart';
import 'package:cryptonia/src/features/kyc/screens/bvn/verify_bvn_otp.dart';
import 'package:cryptonia/src/features/kyc/utils/enums/kyc_type.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/ui_utils.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EnterBvnDetails extends StatefulWidget {
  const EnterBvnDetails({super.key});

  @override
  State<EnterBvnDetails> createState() => _EnterBvnDetailsState();
}

class _EnterBvnDetailsState extends State<EnterBvnDetails> {
  final TextEditingController _bvnController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<KycProvider>(
      builder: (context, kycProv, _) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 32),
                          InkWell(
                            onTap: () => PageNavigation.popPage(context),
                            child: SvgPicture.asset(
                                'assets/svgs/onboarding/close.svg',
                                width: 16,
                                height: 16),
                          ),
                          const SizedBox(height: 32),
                          Text('Enter your BVN',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          const SizedBox(height: 8),
                          Text(
                            'Enter your details ',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.kHintText),
                          ),
                          const SizedBox(height: 32),
                          CustomRoundedTextField(
                            label: 'Enter BVN',
                            hint: '0123456789',
                            controller: _bvnController,
                            onChanged: (val) => kycProv.number = val,
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 19),
                            decoration: BoxDecoration(
                              color: AppColors.kTextField,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text('We only need your BVN for:'),
                                const SizedBox(height: 8),
                                Text(
                                  '   •  Full name\n'
                                  '   •  Phone Number\n'
                                  '   •  Date of Birth',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: AppColors.kHintText),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.info_outline,
                                      color: AppColors.kHintText,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'BVN does not give us access to your bank account or transactions',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: AppColors.kHintText),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                    'Dial *565*0# on your registered number to get your BVN'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomButton(
                    text: 'Continue',
                    onPressed: () async {
                      if (_bvnController.text.isEmpty) {
                        UiUtils.showErrorDialog(context,
                            description: 'Please enter your bvn number');
                        return;
                      }

                      UiUtils.showLoadingIndicatorDialog(context);

                      final res = await kycProv.sendOtp(
                          number: _bvnController.text, type: KycType.bvn);

                      PageNavigation.popPage(context);
                      UiUtils.displayResponse(context, res);

                      if (res.status != Status.success) return;

                      PageNavigation.pushPage(context, const VerifyBvnOtp());
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
