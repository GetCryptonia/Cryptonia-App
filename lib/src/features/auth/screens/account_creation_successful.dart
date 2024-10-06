import 'package:cryptonia/src/features/auth/screens/enable_biometrics.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/theming/page_navigation.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/widgets/container_bg.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountCreationSuccessful extends StatefulWidget {
  const AccountCreationSuccessful({super.key});

  @override
  State<AccountCreationSuccessful> createState() =>
      _AccountCreationSuccessfulState();
}

class _AccountCreationSuccessfulState extends State<AccountCreationSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ContainerBg(
          padding: AppConstants.kScaffoldPadding,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 32),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: SvgPicture.asset(
                            'assets/svgs/onboarding/close.svg'),
                      ),
                    ),
                    const Spacer(),
                    Image.asset(
                      'assets/images/onboarding/target.png',
                      width: 225,
                      height: 225,
                    ),
                    const SizedBox(height: 32),
                    Text('Account Creation Successful!',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 16),
                    Text(
                      'Welcome onboard, we hope to be your platform for buying and selling all your cryptos.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.kHintText),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomButton(
                    text: 'Start Trading',
                    onPressed: () => PageNavigation.pushPage(
                        context, const EnableBiometrics()),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
