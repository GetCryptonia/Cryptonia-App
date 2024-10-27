import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/transaction/screens/order_completed.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderProcessing extends StatefulWidget {
  const OrderProcessing({super.key});

  @override
  State<OrderProcessing> createState() => _OrderProcessingState();
}

class _OrderProcessingState extends State<OrderProcessing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(20),
          child: InkWell(
            onTap: () => PageNavigation.popPage(context),
            child: SvgPicture.asset(
              'assets/svgs/onboarding/close.svg',
              width: 12,
              height: 12,
            ),
          ),
        ),
        title: const Text('Order Processing'),
        backgroundColor: AppColors.kContainerBg,
      ),
      body: ListView(
        padding: AppConstants.kScaffoldPadding,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.kContainerBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Your order is processing...',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.kHintText),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('32 USDT'),
                    const SizedBox(width: 8),
                    SvgPicture.asset(
                        'assets/svgs/history/arrow-up-down-line.svg'),
                    const SizedBox(width: 8),
                    Text('48,499 NGN'),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.kContainerBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bank Account',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.kHintText)),
                Text('9069623646 · Palmpay',
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              PageNavigation.pushPage(context, const OrderCompleted());
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline, color: AppColors.kHintText),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'You’ll be notified once this transaction is completed. '
                    'You can close this page without impacting your transaction',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.kHintText),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
