import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/bank/screens/add_bank_screen.dart';
import 'package:cryptonia/src/features/bank/widgets/bank_card.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:flutter/material.dart';

class BankListScreen extends StatefulWidget {
  const BankListScreen({super.key});

  @override
  State<BankListScreen> createState() => _BankListScreenState();
}

class _BankListScreenState extends State<BankListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Bank Account'),
      ),
      body: ListView(
        padding: AppConstants.kScaffoldPadding,
        children: [
          BankCard(
            image:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6dcuBlGF43-S2sxFusqq2R9Gtg9CJPOrzRQ&s',
            bankName: 'Palmpay',
            accountName: 'Temidayo Olayinka',
            accountNumber: '9069623646',
            onTap: () {},
          ),
          BankCard(
            image:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6dcuBlGF43-S2sxFusqq2R9Gtg9CJPOrzRQ&s',
            bankName: 'Palmpay',
            accountName: 'Temidayo Olayinka',
            accountNumber: '9069623646',
            onTap: () {},
          ),
          TextButton(
            onPressed: () =>
                PageNavigation.pushPage(context, const AddBankScreen()),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add_circle_outline_rounded, size: 20),
                SizedBox(width: 10),
                Text('Add new account'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
