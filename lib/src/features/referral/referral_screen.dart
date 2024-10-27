import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/widgets/empty_widget.dart';
import 'package:flutter/material.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Referral'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.kContainerBg,
                borderRadius: BorderRadius.circular(128),
              ),
              child: Text(
                'Coming Soon',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.kHintText),
              ),
            ),
            const SizedBox(height: 16),
            const EmptyWidget(
              image: 'assets/images/referral/hour-glass.png',
              title: 'Refer and Earn',
              body: 'Earn 1000 for every of your friend \n'
                  'that completes a new trade.',
            ),
          ],
        ),
      ),
    );
  }
}
