import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/auth/providers/auth_provider.dart';
import 'package:cryptonia/src/features/home/screens/nav_home.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/utils/ui_utils.dart';
import 'package:cryptonia/src/shared/widgets/container_bg.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EnableBiometrics extends StatefulWidget {
  const EnableBiometrics({super.key});

  @override
  State<EnableBiometrics> createState() => _EnableBiometricsState();
}

class _EnableBiometricsState extends State<EnableBiometrics> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProv, _) {
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
                        onPressed: () async {
                          final res =
                              await authProv.authenticateWithBiometrics();

                          if (res.status == Status.error) {
                            UiUtils.showErrorDialog(context,
                                description: res.message,
                                title: 'Biometrics Error');
                            return;
                          }

                          final stored = await authProv.storeLoginDetails();

                          if (stored.status == Status.error) {
                            UiUtils.showErrorDialog(context,
                                description: stored.message,
                                title: 'Biometrics Error');
                            return;
                          }

                          PageNavigation.pushPage(context, const NavHome());
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        text: 'No Thanks',
                        onPressed: () =>
                            PageNavigation.pushPage(context, const NavHome()),
                        color: AppColors.kTextField,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
