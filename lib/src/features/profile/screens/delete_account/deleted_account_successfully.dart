import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class DeletedAccountSuccessfully extends StatefulWidget {
  const DeletedAccountSuccessfully({super.key});

  @override
  State<DeletedAccountSuccessfully> createState() =>
      _DeletedAccountSuccessfullyState();
}

class _DeletedAccountSuccessfullyState
    extends State<DeletedAccountSuccessfully> {
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
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 32),
                Icon(Icons.check_circle, size: 50, color: Colors.green),
                SizedBox(height: 16),
                Text(
                  'Your Account has been deleted',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const Spacer(),
            CustomButton(
              text: 'Close App',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
