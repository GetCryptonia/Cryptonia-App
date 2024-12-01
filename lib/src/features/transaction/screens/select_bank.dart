import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/bank/providers/bank_provider.dart';
import 'package:cryptonia/src/features/bank/screens/add_bank_screen.dart';
import 'package:cryptonia/src/features/transaction/providers/transaction_provider.dart';
import 'package:cryptonia/src/features/transaction/screens/order_summary.dart';
import 'package:cryptonia/src/features/transaction/widgets/select_bank_card.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/utils/ui_utils.dart';
import 'package:cryptonia/src/shared/widgets/api_response_future_builder.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectBank extends StatefulWidget {
  const SelectBank({super.key});

  @override
  State<SelectBank> createState() => _SelectBankState();
}

class _SelectBankState extends State<SelectBank> {
  late Future<ApiResponse> _future;

  @override
  void initState() {
    _future = context.read<BankProvider>().fetchUserAccounts(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BankProvider>(
      builder: (context, bankProv, _) {
        return Consumer<TransactionProvider>(
          builder: (context, transactionProv, _) {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: true,
                title: const Text('Select Bank Account'),
                backgroundColor: AppColors.kContainerBg,
              ),
              body: ApiResponseFutureBuilder(
                future: _future,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ListView(
                        padding: AppConstants.kScaffoldPadding,
                        children: [
                          if (bankProv.accounts.isEmpty)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: EmptyWidget(
                                    image:
                                        'assets/images/notification/notification-empty.png',
                                    title: 'No Bank Account',
                                    body: 'You do not have any bank account \n'
                                        'linked to your profile.'),
                              ),
                            ),
                          ...bankProv.accounts.map((e) {
                            return SelectBankCard(
                              account: e,
                              selected: bankProv.account == e,
                              onTap: () {
                                bankProv.account = e;
                                bankProv.bank = bankProv.account?.toBank();
                              },
                            );
                          }),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () => PageNavigation.pushPage(
                                context, const AddBankScreen()),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add_circle_outline_rounded,
                                    size: 20),
                                SizedBox(width: 10),
                                Text('Add new account'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (bankProv.accounts.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomButton(
                          text: 'Confirm',
                          onPressed: () async {
                            if (bankProv.account == null) {
                              UiUtils.showSnackBar(
                                  context, 'Select an account');
                              return;
                            }

                            UiUtils.showLoadingIndicatorDialog(context);

                            final nameRes = await bankProv.verifyAccountName(
                                bankProv.account!.accountNumber);

                            PageNavigation.popPage(context);

                            if (nameRes.status == Status.error ||
                                bankProv.accountName == null) {
                              UiUtils.displayResponse(context, nameRes);
                              return;
                            }

                            UiUtils.showLoadingIndicatorDialog(context);

                            final res = await transactionProv.createSellOrder(
                                bankAccountId: bankProv.account!.id,
                                sessionId: bankProv.accountName!.sessionId);

                            PageNavigation.popPage(context);

                            if (res.status == Status.error) {
                              UiUtils.displayResponse(context, res);
                              return;
                            }

                            PageNavigation.pushPage(
                                context, const OrderSummary());
                          },
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
