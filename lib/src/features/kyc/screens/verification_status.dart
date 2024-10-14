import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/kyc/screens/enter_bvn_details.dart';
import 'package:cryptonia/src/features/kyc/screens/enter_nin_details.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:flutter/material.dart';

class VerificationStatus extends StatefulWidget {
  const VerificationStatus({super.key});

  @override
  State<VerificationStatus> createState() => _VerificationStatusState();
}

class _VerificationStatusState extends State<VerificationStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
            padding: EdgeInsets.symmetric(horizontal: 16),
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
            title: 'Verify Email',
            subtitle: 'Trade up to \$100 or 150,000 NGN',
            verified: true,
          ),
          _verificationStepTile(
            title: 'Verify BVN',
            subtitle: 'Increase your limit to \$1000 or 1,000,000 NGN',
            verified: false,
            onTap: () =>
                PageNavigation.pushPage(context, const EnterBvnDetails()),
          ),
          _verificationStepTile(
            title: 'Verify NIN',
            subtitle: 'Unlimited trade volume',
            verified: false,
            onTap: () =>
                PageNavigation.pushPage(context, const EnterNinDetails()),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  _verificationStepTile({
    required String title,
    required String subtitle,
    required bool verified,
    VoidCallback? onTap,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: onTap,
          title: Text(title),
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
