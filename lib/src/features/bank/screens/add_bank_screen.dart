import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/bank/providers/bank_provider.dart';
import 'package:cryptonia/src/features/bank/screens/select_bank_bottom_sheet.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/utils/ui_utils.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBankScreen extends StatefulWidget {
  const AddBankScreen({super.key});

  @override
  State<AddBankScreen> createState() => _AddBankScreenState();
}

class _AddBankScreenState extends State<AddBankScreen> {
  final TextEditingController _bankController = TextEditingController();
  final TextEditingController _accountNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BankProvider>().bank = null;
      context.read<BankProvider>().accountName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BankProvider>(
      builder: (context, bankProv, _) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text('Account'),
            backgroundColor: AppColors.kContainerBg,
          ),
          body: Padding(
            padding: AppConstants.kScaffoldPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      const Text(
                          'Add your bank account for completing exchanges'),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.info_outline,
                              color: AppColors.kHintText, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'Only personal accounts are allowed',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.kHintText),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomRoundedTextField(
                        readOnly: true,
                        label: 'Select Bank',
                        controller: _bankController,
                        initialValue: bankProv.bank?.name,
                        suffixIcon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColors.kHintText,
                            size: 20),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return SelectBankBottomSheet(
                                onBankSelected: (bank) {
                                  bankProv.bank = bank;

                                  setState(() {
                                    AppConstants.setTextFieldValue(
                                        controller: _bankController,
                                        text: bankProv.bank!.name);
                                  });
                                },
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomRoundedTextField(
                        maxLength: 10,
                        label: 'Enter Account Number',
                        controller: _accountNumber,
                        onChanged: (val) async {
                          if (val.length < 10) return;

                          await bankProv.verifyAccountName(val);
                        },
                      ),
                      const SizedBox(height: 16),
                      if (bankProv.accountName != null)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            bankProv.accountName!.accountName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context).primaryColor),
                          ),
                        ),
                    ],
                  ),
                ),
                if (bankProv.banks.length < 10)
                  CustomButton(
                    text: 'Add Bank Account',
                    onPressed: () async {
                      UiUtils.showLoadingIndicatorDialog(context);

                      final res = await bankProv.createUserAccount();

                      PageNavigation.popPage(context);

                      UiUtils.displayResponse(context, res);

                      if (res.status != Status.success) return;

                      await Future.delayed(const Duration(seconds: 2), () {
                        PageNavigation.popPage(context);
                      });
                    },
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
