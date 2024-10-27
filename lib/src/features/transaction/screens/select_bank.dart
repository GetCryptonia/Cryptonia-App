import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/bank/screens/add_bank_screen.dart';
import 'package:cryptonia/src/features/transaction/screens/order_summary.dart';
import 'package:cryptonia/src/features/transaction/widgets/select_bank_card.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/empty_widget.dart';
import 'package:flutter/material.dart';

class SelectBank extends StatefulWidget {
  const SelectBank({super.key});

  @override
  State<SelectBank> createState() => _SelectBankState();
}

class _SelectBankState extends State<SelectBank> {
  bool empty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: GestureDetector(
          onTap: () {
            setState(() {
              empty = !empty;
            });
          },
          child: const Text('Select Bank Account'),
        ),
        backgroundColor: AppColors.kContainerBg,
      ),
      body: empty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const EmptyWidget(
                      image:
                          'assets/images/notification/notification-empty.png',
                      title: 'No Bank Account',
                      body: 'You do not have any bank account \n'
                          'linked to your profile.'),
                  const SizedBox(height: 16),
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
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    padding: AppConstants.kScaffoldPadding,
                    children: [
                      SelectBankCard(
                        selected: true,
                        image: AppConstants.palmPayPic,
                        bankName: 'Palmpay',
                        accountName: 'Temidayo Olayinka',
                        accountNumber: '9069623646',
                        onTap: () {},
                      ),
                      SelectBankCard(
                        selected: false,
                        image: AppConstants.palmPayPic,
                        bankName: 'Palmpay',
                        accountName: 'Temidayo Olayinka',
                        accountNumber: '9069623646',
                        onTap: () {},
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => PageNavigation.pushPage(
                            context, const AddBankScreen()),
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomButton(
                    text: 'Confirm',
                    onPressed: () {
                      PageNavigation.pushPage(context, const OrderSummary());
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
