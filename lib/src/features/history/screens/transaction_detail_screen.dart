import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/history/models/order_model.dart';
import 'package:cryptonia/src/features/history/providers/history_provider.dart';
import 'package:cryptonia/src/features/history/screens/report_transaction_screen.dart';
import 'package:cryptonia/src/features/transaction/utils/enums/tokens_enum.dart';
import 'package:cryptonia/src/features/transaction/utils/enums/transaction_status.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/utils/date_time_utils.dart';
import 'package:cryptonia/src/shared/utils/double_utils.dart';
import 'package:cryptonia/src/shared/utils/ui_utils.dart';
import 'package:cryptonia/src/shared/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TransactionDetailScreen extends StatefulWidget {
  const TransactionDetailScreen({super.key});

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(
      builder: (context, historyProv, _) {
        OrderModel? order = historyProv.order;
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text('Transaction Details'),
          ),
          body: order == null
              ? const Center(
                  child: EmptyWidget(
                    title: 'Oops!',
                    body: "Couldn't get details.",
                  ),
                )
              : ListView(
                  padding: AppConstants.kScaffoldPadding,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 32),
                      decoration: BoxDecoration(
                        color: AppColors.kContainerBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // CircleAvatar(
                          //   radius: 16,
                          //   backgroundImage:
                          //       NetworkImage(AppConstants.palmPayPic),
                          // ),
                          // const SizedBox(height: 16),
                          Text(
                            'You sold',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppColors.kHintText),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "${order.tokenAmount.toReadable} ${order.token.symbol}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          SvgPicture.asset(
                            'assets/svgs/history/arrow-up-down-line.svg',
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${order.fiatAmount.toReadable} NGN",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.kContainerBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _breakdownRow(
                              title: 'Status',
                              value: order.status.label,
                              showLeading: true),
                          const Divider(),
                          _breakdownRow(
                              title: 'Rate',
                              value:
                                  '${order.fiatAmount / order.tokenAmount} NGN/${order.token.symbol}'),
                          const Divider(),
                          //_breakdownRow(title: 'Fee', value: 'USDT 0.50'),
                          const Divider(),
                          _breakdownRow(
                              title: 'Date',
                              value: order.createdAt.toReadableWithTime),
                          const Divider(),
                          _breakdownRow(
                              title: "Receiver's Name",
                              value: order.receiverAccountName),
                          const Divider(),
                          _breakdownRow(
                              title: 'Bank',
                              value:
                                  '${order.receiverAccountNumber} · ${order.receiverBank}'),
                          const Divider(),
                          _breakdownRow(
                              title: 'Transaction ID',
                              value: order.id,
                              showCopy: true),
                          const Divider(),
                          _breakdownRow(
                              title: 'Session ID',
                              value: order.receiverSessionId,
                              showCopy: true),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.info_outline,
                                color: AppColors.kHintText,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Contact your bank with this ID\nif you do not get paid in 12hrs',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: AppColors.kHintText),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        PageNavigation.pushPage(
                            context, const ReportTransactionScreen());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.kContainerBg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svgs/history/chat-3-line.svg',
                              width: 16,
                              height: 16,
                            ),
                            const SizedBox(width: 4),
                            Text('Report Transaction',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: AppColors.kPrimary)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
        );
      },
    );
  }

  Widget _breakdownRow({
    required String title,
    required String value,
    bool showCopy = false,
    bool showLeading = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
          if (showLeading) const Spacer(),
          if (showLeading)
            const Icon(
              Icons.check_circle,
              color: AppColors.kGreenCheck,
              size: 18,
            ),
          const SizedBox(width: 4),
          showLeading
              ? Text(
                  value,
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              : Expanded(
                  child: Text(
                    value,
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
          const SizedBox(width: 4),
          if (showCopy)
            InkWell(
              onTap: () {
                Clipboard.setData(ClipboardData(text: value));
                UiUtils.showSnackBar(context, 'Copied');
              },
              child: const Icon(Icons.copy, size: 20),
            )
        ],
      ),
    );
  }
}
