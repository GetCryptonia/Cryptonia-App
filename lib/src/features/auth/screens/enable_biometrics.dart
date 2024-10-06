import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/widgets/container_bg.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EnableBiometrics extends StatefulWidget {
  const EnableBiometrics({super.key});

  @override
  State<EnableBiometrics> createState() => _EnableBiometricsState();
}

class _EnableBiometricsState extends State<EnableBiometrics> {
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
                      'assets/images/onboarding/safe.png',
                      width: 225,
                      height: 225,
                    ),
                    const SizedBox(height: 32),
                    Text('Enable Biometrics',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 16),
                    Text(
                      'You can choose to login with your face ID or '
                      'fingerprints using your device biometrics',
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
                    text: 'Enable',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'No Thanks',
                    onPressed: () {},
                    color: AppColors.kTextField,
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
