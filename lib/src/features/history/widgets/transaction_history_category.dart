import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/history/screens/transaction_detail_screen.dart';
import 'package:cryptonia/src/features/history/widgets/transaction_tile.dart';
import 'package:cryptonia/src/features/transaction/utils/enums/tokens_enum.dart';
import 'package:cryptonia/src/features/transaction/utils/enums/transaction_status.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

class TransactionHistoryCategory extends StatelessWidget {
  final DateTime date;
  const TransactionHistoryCategory({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.kHistoryCategory,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              date.toCategory,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.kHintText),
            ),
          ),
          TransactionTile(
            onTap: () {
              PageNavigation.pushPage(context, const TransactionDetailScreen());
            },
            token: TokenType.usdTErc,
            address: '0x19b9Aa...',
            date: DateTime.now(),
            amount: 100,
            status: TransactionStatus.successful,
          ),
          TransactionTile(
            onTap: () {
              PageNavigation.pushPage(context, const TransactionDetailScreen());
            },
            token: TokenType.ngn,
            address: '9069623646',
            date: DateTime.now(),
            amount: 100000,
            status: TransactionStatus.processing,
          ),
        ],
      ),
    );
  }
}
