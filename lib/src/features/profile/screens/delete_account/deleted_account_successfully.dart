import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/auth/screens/sign_in.dart';
import 'package:cryptonia/src/features/bank/providers/bank_provider.dart';
import 'package:cryptonia/src/features/history/providers/history_provider.dart';
import 'package:cryptonia/src/features/kyc/provider/kyc_provider.dart';
import 'package:cryptonia/src/features/notification/provider/notification_provider.dart';
import 'package:cryptonia/src/features/transaction/providers/transaction_provider.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        automaticallyImplyLeading: false,
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
              text: 'Done',
              onPressed: () {
                //clear all and replace page with the login screen and pop all stack

                context.read<TransactionProvider>().clearAll();
                context.read<HistoryProvider>().clearAll();
                context.read<NotificationProvider>().clearAll();
                context.read<KycProvider>().clearAll();
                context.read<BankProvider>().clearAll();

                PageNavigation.replaceAll(context, const SignIn());
              },
            ),
          ],
        ),
      ),
    );
  }
}
