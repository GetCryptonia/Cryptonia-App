import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/bank/providers/bank_provider.dart';
import 'package:cryptonia/src/features/bank/screens/add_bank_screen.dart';
import 'package:cryptonia/src/features/bank/widgets/bank_card.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/utils/ui_utils.dart';
import 'package:cryptonia/src/shared/widgets/api_response_future_builder.dart';
import 'package:cryptonia/src/shared/widgets/confirmation_bottom_sheet.dart';
import 'package:cryptonia/src/shared/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BankListScreen extends StatefulWidget {
  const BankListScreen({super.key});

  @override
  State<BankListScreen> createState() => _BankListScreenState();
}

class _BankListScreenState extends State<BankListScreen> {
  late Future<ApiResponse> _fetchAccounts;

  @override
  void initState() {
    super.initState();
    _fetchAccounts = context.read<BankProvider>().fetchUserAccounts(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Bank Account'),
      ),
      body: ApiResponseFutureBuilder(
        future: _fetchAccounts,
        child: Consumer<BankProvider>(
          builder: (context, bankProv, _) {
            return ListView(
              padding: AppConstants.kScaffoldPadding,
              children: [
                if (bankProv.accounts.isEmpty)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height * 0.2),
                      child: const EmptyWidget(
                          title: 'Nothing here.',
                          body: "You haven't added a bank account yet"),
                    ),
                  ),
                ...bankProv.accounts.map(
                  (account) {
                    return BankCard(
                      account: account,
                      onTap: () {},
                      onDelete: () async {
                        final ApiResponse? res = await showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return ConfirmationBottomSheet(
                              message:
                                  'Are you sure you want delete this account?',
                              onTap: () async {
                                ApiResponse response = await bankProv
                                    .removeUserAccount(account.id);

                                PageNavigation.pop(context, response);
                              },
                            );
                          },
                        );

                        if (res == null) return;

                        UiUtils.displayResponse(context, res);
                      },
                    );
                  },
                ),
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
            );
          },
        ),
      ),
    );
  }
}
