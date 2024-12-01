import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/history/models/order_model.dart';
import 'package:cryptonia/src/features/transaction/providers/transaction_provider.dart';
import 'package:cryptonia/src/features/transaction/screens/order_processing.dart';
import 'package:cryptonia/src/features/transaction/utils/enums/tokens_enum.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/utils/num_extension.dart';
import 'package:cryptonia/src/shared/utils/string_utils.dart';
import 'package:cryptonia/src/shared/utils/ui_utils.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({super.key});

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, transactionProv, _) {
        OrderModel? order = transactionProv.sellOrder;
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text('Order Summary'),
            backgroundColor: AppColors.kContainerBg,
          ),
          body: order == null
              ? const Center(
                  child: EmptyWidget(
                    title: 'Oops!',
                    body: "Could not fetch order details. "
                        "Don't worry your order is processing "
                        "in the background.",
                  ),
                )
              : Padding(
                  padding: AppConstants.kScaffoldPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.kContainerBg,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text('Deposit Address'),
                                  const SizedBox(height: 16),
                                  QrImageView(
                                    data: order.address,
                                    version: QrVersions.auto,
                                    size: 150.0,
                                    backgroundColor: Colors.white,
                                  ),
                                  const SizedBox(height: 16),
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _tradeDetailRow(
                                            title: 'Send',
                                            value:
                                                '${order.tokenAmount} ${order.token.symbol}'),
                                        _tradeDetailRow(
                                          title: 'Token',
                                          value: order.token.network,
                                          trailing: CircleAvatar(
                                            radius: 10,
                                            backgroundImage:
                                                AssetImage(order.token.asset),
                                          ),
                                        ),
                                        _tradeDetailRow(
                                          title: 'Address',
                                          value: '',
                                          subTitle:
                                              order.address.censoredAddress(),
                                          trailing: InkWell(
                                            onTap: () {
                                              Clipboard.setData(ClipboardData(
                                                  text: order.address));
                                              UiUtils.showSnackBar(
                                                  context, 'Copied address');
                                            },
                                            child: const Icon(
                                                Icons.copy_rounded,
                                                size: 23),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.info_outline,
                                          color: AppColors.kHintText),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Ensure you select the correct asset and '
                                          'network for deposits. Funds sent to the wrong '
                                          'asset or network cannot be recovered.',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  color: AppColors.kHintText),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: AppColors.kContainerBg,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text('Trade Details'),
                                  const SizedBox(height: 16),
                                  const Divider(),
                                  _tradeDetailRow(
                                      title: 'You Receive',
                                      value:
                                          '${order.fiatAmount.toReadable} NGN'),
                                  // _tradeDetailRow(
                                  //     title: 'Fee', value: '1,000 NGN'),
                                  _tradeDetailRow(
                                      title: 'Paid to',
                                      value: order.receiverAccountName),
                                  _tradeDetailRow(
                                      title: 'Bank Account',
                                      value:
                                          '${order.receiverAccountNumber} · ${order.receiverBank}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        onPressed: () {
                          PageNavigation.pushPage(
                              context, const OrderProcessing());
                        },
                        text: "I've sent the crypto",
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }

  Widget _tradeDetailRow({
    required String title,
    required String value,
    Widget? trailing,
    String? subTitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.kHintText),
              ),
              if (subTitle != null) const SizedBox(height: 8),
              if (subTitle != null)
                Text(
                  subTitle,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(width: 8),
          trailing ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
