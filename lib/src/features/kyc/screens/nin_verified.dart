import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/kyc/screens/nin_not_verified.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class NinVerified extends StatefulWidget {
  const NinVerified({super.key});

  @override
  State<NinVerified> createState() => _NinVerifiedState();
}

class _NinVerifiedState extends State<NinVerified> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.kTextField,
        title: const Text('NIN Verified'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.kTextField,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, size: 50, color: Colors.green),
                  const SizedBox(height: 16),
                  Text(
                    'NIN Verified',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Increase your limit to \$1000 or 1,000,000 NGN',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Spacer(),
            CustomButton(
              text: 'Go Home',
              onPressed: () =>
                  PageNavigation.pushPage(context, const NinNotVerified()),
            ),
          ],
        ),
      ),
    );
  }
}
