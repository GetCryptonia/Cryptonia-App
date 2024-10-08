import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/auth/providers/auth_provider.dart';
import 'package:cryptonia/src/features/auth/screens/verify_sign_up_email.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/utils/ui_utils.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SelectAvatar extends StatefulWidget {
  const SelectAvatar({super.key});

  @override
  State<SelectAvatar> createState() => _SelectAvatarState();
}

class _SelectAvatarState extends State<SelectAvatar> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProv, _) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => PageNavigation.popPage(context),
              icon: SvgPicture.asset(
                  'assets/svgs/onboarding/arrow-left-line.svg'),
            ),
            title: const Text('Select Avatars'),
          ),
          body: Padding(
            padding: AppConstants.kScaffoldPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select an avatar of your choice',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    padding: const EdgeInsets.all(0),
                    children: List.generate(
                      12,
                      (index) {
                        return Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selected = index;
                              });
                            },
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                Colors.black
                                    .withOpacity(selected == index ? 0 : 0.5),
                                BlendMode.darken,
                              ),
                              child: Container(
                                width: 100,
                                height: 100,
                                margin: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Image.asset(
                                  'assets/images/avatars/${index + 1}.png',
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                CustomButton(
                  text: 'Next',
                  onPressed: () async {
                    authProv.signupRequestModel?.avatar =
                        'assets/images/avatars/${selected + 1}.png';

                    UiUtils.showLoadingIndicatorDialog(context);

                    final res = await authProv.signUp(
                      email: authProv.signupRequestModel!.email,
                      username: authProv.signupRequestModel!.username,
                      password: authProv.signupRequestModel!.password,
                      avatar: authProv.signupRequestModel!.avatar,
                      referralCode: authProv.signupRequestModel!.referralCode,
                    );

                    await authProv.sendOtp(authProv.signupRequestModel!.email);

                    PageNavigation.popPage(context);

                    if (res.status == Status.error) {
                      UiUtils.showErrorDialog(context,
                          description: res.errorMessage ?? 'An error occurred');
                      return;
                    }

                    PageNavigation.pushPage(context, const VerifySignUpEmail());
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
