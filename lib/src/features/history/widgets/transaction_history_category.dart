import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/history/models/order_model.dart';
import 'package:cryptonia/src/features/history/providers/history_provider.dart';
import 'package:cryptonia/src/features/history/screens/transaction_detail_screen.dart';
import 'package:cryptonia/src/features/history/widgets/transaction_tile.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionHistoryCategory extends StatelessWidget {
  final DateTime date;
  final List<OrderModel> orders;
  const TransactionHistoryCategory({
    super.key,
    required this.date,
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(
      builder: (context, historyProv, _) {
        return ColoredBox(
          color: AppColors.kHistoryCategory,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(
                  date.toCategory,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.kHintText),
                ),
              ),
              ...orders.map(
                (e) => TransactionTile(
                  order: e,
                  onTap: () {
                    historyProv.order = e;

                    PageNavigation.pushPage(
                        context, const TransactionDetailScreen());
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
