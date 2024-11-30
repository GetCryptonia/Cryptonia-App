import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/kyc/screens/nin/nin_verified.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EnterNinDetails extends StatefulWidget {
  const EnterNinDetails({super.key});

  @override
  State<EnterNinDetails> createState() => _EnterNinDetailsState();
}

class _EnterNinDetailsState extends State<EnterNinDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
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
                    Text('Enter your NIN',
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 8),
                    Text(
                      'Enter your details ',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.kHintText),
                    ),
                    const SizedBox(height: 32),
                    const Row(
                      children: [
                        Expanded(
                          child: CustomRoundedTextField(
                            label: 'First Name',
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: CustomRoundedTextField(
                            label: 'Last Name',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 17),
                          decoration: BoxDecoration(
                            color: AppColors.kTextField,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CircleAvatar(
                                radius: 10,
                                backgroundImage: AssetImage(
                                    'assets/images/nigerian-flag.png'),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '+234',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: AppColors.kHintText),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: CustomRoundedTextField(
                            label: 'Enter NIN Phone Number',
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    const CustomRoundedTextField(label: 'Enter NIN'),
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
                          const Text('We only need your NIN for:'),
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
                                  'NIN does not give us access to your bank account or transactions',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: AppColors.kHintText),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton(
                text: 'Continue',
                onPressed: () =>
                    PageNavigation.pushPage(context, const NinVerified()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
