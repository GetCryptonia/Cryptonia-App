import 'package:cryptonia/src/features/notification/models/notification_model.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final VoidCallback onTap;
  final NotificationModel notification;
  const NotificationCard(
      {super.key, required this.onTap, required this.notification});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.kPrimary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    notification.title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              notification.message,
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.kHintText),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  notification.createdAt.toReadable,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.kFadedText),
                ),
                const Spacer(),
                Text(
                  'Read more',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.kFadedText),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward,
                    size: 18, color: AppColors.kFadedText),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
