import 'package:cryptonia/src/features/transaction/utils/enums/tokens_enum.dart';
import 'package:cryptonia/src/features/transaction/utils/enums/transaction_status.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/date_time_utils.dart';
import 'package:cryptonia/src/shared/utils/int_utils.dart';
import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final TokenType token;
  final String address;
  final DateTime date;
  final int amount;
  final TransactionStatus status;
  final VoidCallback onTap;
  const TransactionTile({
    super.key,
    required this.token,
    required this.address,
    required this.date,
    required this.amount,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.kContainerBg,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 16,
          backgroundImage: AssetImage(token.asset),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            address,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        subtitle: Text(
          date.toReadableWithTime,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: AppColors.kHintText),
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${amount.toReadable} ${token.label}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                status.icon,
                const SizedBox(width: 5),
                Text(
                  status.label,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.kHintText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
