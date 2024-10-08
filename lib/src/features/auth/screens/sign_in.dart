import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/auth/providers/auth_provider.dart';
import 'package:cryptonia/src/features/auth/screens/enable_biometrics.dart';
import 'package:cryptonia/src/features/auth/screens/enter_email.dart';
import 'package:cryptonia/src/features/auth/screens/sign_up.dart';
import 'package:cryptonia/src/features/home/screens/home_screen.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/utils/ui_utils.dart';
import 'package:cryptonia/src/shared/widgets/container_bg.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 60),
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                                'assets/images/onboarding/logo.png',
                                fit: BoxFit.cover,
                                height: 74,
                                width: 99),
                          ),
                          const SizedBox(height: 60),
                          Text(
                            'Let’s get trading',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppColors.kHintText),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Welcome Back',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 32),
                          CustomRoundedTextField(
                            label: 'Email',
                            hint: 'Enter your email',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),
                          CustomRoundedTextField(
                            obscureText: true,
                            visibilityIcons: true,
                            label: 'Password',
                            hint: 'Enter your password',
                            controller: _passwordController,
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () => PageNavigation.pushPage(
                                  context, const EnterEmail()),
                              child: const Text('Forgot Password?'),
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                            onPressed: () async {
                              UiUtils.showLoadingIndicatorDialog(context);

                              final res = await authProv.login(
                                  email: _emailController.text,
                                  password: _passwordController.text);

                              final biometricRes =
                                  await authProv.canUseBiometrics();

                              PageNavigation.popPage(context);

                              if (res.status == Status.error) {
                                UiUtils.showErrorDialog(
                                  context,
                                  title: res.message,
                                  description: res.errorMessage ?? '',
                                );
                                return;
                              }

                              //check if biometrics is enabled.
                              //If so, navigate to home screen
                              //else navigate user to enable biometrics screen
                              PageNavigation.pushPage(
                                context,
                                biometricRes
                                    ? const EnableBiometrics()
                                    : const HomeScreen(),
                              );
                            },
                            text: 'Sign In',
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () async {
                                //check if user can use biometrics
                                final biometricRes =
                                    await authProv.canUseBiometrics();

                                if (!biometricRes) {
                                  UiUtils.showErrorDialog(
                                    context,
                                    title: 'Biometrics Error',
                                    description:
                                        'Biometrics is not available on this device',
                                  );
                                  return;
                                }

                                //check for stored auth details
                                await authProv.fetchLoginDetails();

                                //if stored details is null return error
                                if (authProv.loginDetails == null) {
                                  UiUtils.showErrorDialog(
                                    context,
                                    title: 'Biometrics Error',
                                    description:
                                        'No stored login details found',
                                  );
                                  return;
                                }

                                //else authenticate with biometrics
                                final res =
                                    await authProv.authenticateWithBiometrics();

                                if (res.status == Status.error) {
                                  UiUtils.showErrorDialog(
                                    context,
                                    title: 'Biometrics Error',
                                    description: res.message,
                                  );
                                  return;
                                }

                                UiUtils.showLoadingIndicatorDialog(context);

                                //sign in user
                                final loginRes = await authProv.login(
                                  email: authProv.loginDetails!.email,
                                  password: authProv.loginDetails!.password,
                                );

                                PageNavigation.popPage(context);

                                if (loginRes.status == Status.error) {
                                  UiUtils.showErrorDialog(
                                    context,
                                    title: loginRes.message,
                                    description: loginRes.errorMessage ?? '',
                                  );
                                  return;
                                }

                                //navigate to home screen
                                PageNavigation.pushPage(
                                    context, const HomeScreen());
                              },
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: AppColors.kTextField,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                      'assets/svgs/auth/fingerprint.svg',
                                      width: 14,
                                      height: 27),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () =>
                            PageNavigation.pushPage(context, const SignUp()),
                        child: const Text('Sign Up'),
                      ),
                    ],
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
