import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class EmailChangedSuccessfully extends StatefulWidget {
  const EmailChangedSuccessfully({super.key});

  @override
  State<EmailChangedSuccessfully> createState() =>
      _EmailChangedSuccessfullyState();
}

class _EmailChangedSuccessfullyState extends State<EmailChangedSuccessfully> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.kTextField,
        title: const Text('Email Changed'),
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
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, size: 50, color: Colors.green),
                  SizedBox(height: 16),
                  Text(
                    'Email Address\nUpdated!',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Spacer(),
            CustomButton(
              text: 'Go Back',
              onPressed: () => PageNavigation.popPage(context, 3),
            ),
          ],
        ),
      ),
    );
  }
}
