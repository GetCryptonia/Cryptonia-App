import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:flutter/material.dart';

class NinNotVerified extends StatefulWidget {
  const NinNotVerified({super.key});

  @override
  State<NinNotVerified> createState() => _NinNotVerifiedState();
}

class _NinNotVerifiedState extends State<NinNotVerified> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => PageNavigation.popPage(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.kTextField,
        title: const Text('NIN verification'),
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
                  const Icon(Icons.info, size: 50, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'NIN Verification Failed',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  const Text('Please try again or ',
                      textAlign: TextAlign.center),
                  Text(
                    'contact support',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.kPrimary,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
