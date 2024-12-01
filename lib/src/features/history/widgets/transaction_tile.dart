import 'package:cryptonia/src/features/history/models/order_model.dart';
import 'package:cryptonia/src/features/transaction/utils/enums/tokens_enum.dart';
import 'package:cryptonia/src/features/transaction/utils/enums/transaction_status.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/date_time_utils.dart';
import 'package:cryptonia/src/shared/utils/num_extension.dart';
import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onTap;
  const TransactionTile({
    super.key,
    required this.order,
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
          backgroundImage: AssetImage(order.token.asset),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            order.address,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        subtitle: Text(
          order.createdAt.toReadableWithTime,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: AppColors.kHintText),
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${order.fiatAmount.toReadable} ${order.token.label}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                order.status.icon,
                const SizedBox(width: 5),
                Text(
                  order.status.label,
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
