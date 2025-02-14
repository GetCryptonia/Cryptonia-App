import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class BvnVerified extends StatefulWidget {
  const BvnVerified({super.key});

  @override
  State<BvnVerified> createState() => _BvnVerifiedState();
}

class _BvnVerifiedState extends State<BvnVerified> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.kTextField,
        title: const Text('BVN Verified'),
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
                    'BVN Verified',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Increased your limit to \$1400',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Spacer(),
            CustomButton(
              text: 'Back',
              onPressed: () => PageNavigation.popPage(context, 3),
            ),
          ],
        ),
      ),
    );
  }
}
