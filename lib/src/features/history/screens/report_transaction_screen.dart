import 'package:cryptonia/src/features/history/models/order_model.dart';
import 'package:cryptonia/src/features/history/providers/history_provider.dart';
import 'package:cryptonia/src/features/transaction/utils/enums/tokens_enum.dart';
import 'package:cryptonia/src/features/transaction/utils/enums/transaction_status.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/date_time_utils.dart';
import 'package:cryptonia/src/shared/utils/ui_utils.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/custom_text_field.dart';
import 'package:cryptonia/src/shared/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportTransactionScreen extends StatefulWidget {
  const ReportTransactionScreen({super.key});

  @override
  State<ReportTransactionScreen> createState() =>
      _ReportTransactionScreenState();
}

class _ReportTransactionScreenState extends State<ReportTransactionScreen> {
  final TextEditingController _description = TextEditingController();
  final TextEditingController _hash = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(
      builder: (context, historyProv, _) {
        OrderModel? order = historyProv.order;
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text('Report Transaction'),
          ),
          body: order == null
              ? const Center(
                  child: EmptyWidget(
                    title: 'Oops!',
                    body: "Couldn't get details.",
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.kContainerBg,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _breakdownRow(
                                      title: 'Transaction Type', value: 'Sell'),
                                  const Divider(),
                                  _breakdownRow(
                                      title: 'Transaction ID', value: order.id),
                                  const Divider(),
                                  _breakdownRow(
                                      title: 'Status',
                                      value: order.status.label),
                                  const Divider(),
                                  _breakdownRow(
                                      title: 'Amount',
                                      value:
                                          '${order.tokenAmount} ${order.token.symbol}'),
                                  const Divider(),
                                  _breakdownRow(
                                      title: 'Date',
                                      value:
                                          order.createdAt.toReadableWithTime),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            CustomRoundedTextField(
                              maxLines: 5,
                              controller: _description,
                              label:
                                  'Enter a detailed description of the issue',
                            ),
                            const SizedBox(height: 16),
                            CustomRoundedTextField(
                              controller: _hash,
                              label: 'Optional: Enter Transaction Hash',
                            ),
                          ],
                        ),
                      ),
                      CustomButton(
                        text: 'Submit',
                        onPressed: () async {
                          if (_description.text.isEmpty) {
                            UiUtils.showSnackBar(
                                context, 'Please enter a description');
                            return;
                          }

                          await UiUtils.sendEmail(
                            context,
                            recipient: 'support@getcryptonia.com',
                            subject: 'Reporting Transaction',
                            body:
                                'Hello, I would like to report a transaction.\n'
                                'Here are the details:\n\n'
                                'Transaction id: ${order.id},\n\n'
                                'Token Amount: ${order.tokenAmount},\n\n'
                                'Transaction Date: ${order.createdAt.toReadable}\n\n'
                                'Transaction hash: ${_hash.text}. \n\n'
                                'Some further description: ${_description.text}',
                          );
                        },
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Widget _breakdownRow({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.kHintText),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.kFadedText),
            ),
          ),
        ],
      ),
    );
  }
}
