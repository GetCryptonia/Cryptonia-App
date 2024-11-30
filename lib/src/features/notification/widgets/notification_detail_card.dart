import 'package:cryptonia/src/features/notification/models/notification_model.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

class NotificationDetailCard extends StatelessWidget {
  final NotificationModel notification;
  const NotificationDetailCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kContainerBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                notification.createdAt.toReadable,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.kFadedText),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            notification.title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          Text(
            notification.message,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.kHintText),
          ),
        ],
      ),
    );
  }
}
