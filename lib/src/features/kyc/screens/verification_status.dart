import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/auth/providers/auth_provider.dart';
import 'package:cryptonia/src/features/kyc/screens/bvn/enter_bvn_details.dart';
import 'package:cryptonia/src/features/kyc/utils/enums/kyc_type.dart';
import 'package:cryptonia/src/features/profile/providers/profile_provider.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerificationStatus extends StatefulWidget {
  const VerificationStatus({super.key});

  @override
  State<VerificationStatus> createState() => _VerificationStatusState();
}

class _VerificationStatusState extends State<VerificationStatus> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProv, _) {
        return Consumer<ProfileProvider>(
          builder: (context, profileProv, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.kHintText,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => PageNavigation.popPage(context),
                        child: const Icon(Icons.arrow_back, size: 20),
                      ),
                      const Text('Complete Verification'),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                _verificationStepTile(
                  proceed: profileProv.userProfileModel?.emailVerified == false,
                  title: 'Verify Email',
                  subtitle: 'Convert up to \$300',
                  verified:
                      profileProv.userProfileModel?.emailVerified ?? false,
                ),
                _verificationStepTile(
                  proceed:
                      profileProv.userProfileModel?.emailVerified == true &&
                          profileProv.userProfileModel?.kyc == null,
                  title: 'Verify BVN',
                  subtitle: 'Increase your limit to \$600',
                  verified: profileProv.userProfileModel?.kyc == KycType.bvn,
                  onTap: () =>
                      PageNavigation.pushPage(context, const EnterBvnDetails()),
                ),
                // _verificationStepTile(
                //   title: 'Verify NIN',
                //   subtitle: 'Increase your limit to \$900',
                //   verified: false,
                //   onTap: () =>
                //       PageNavigation.pushPage(context, const EnterNinDetails()),
                // ),
                const SizedBox(height: 30),
              ],
            );
          },
        );
      },
    );
  }

  _verificationStepTile({
    required String title,
    required String subtitle,
    required bool verified,
    required bool proceed,
    VoidCallback? onTap,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: () {
            if (verified) return;

            onTap?.call();
          },
          title: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          subtitle: Text(
            subtitle,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.kHintText),
          ),
          trailing: Icon(
              verified ? Icons.check_circle : Icons.arrow_forward_ios_rounded,
              color: verified ? AppColors.kGreenCheck : Colors.white),
        ),
        const Divider(),
      ],
    );
  }
}
