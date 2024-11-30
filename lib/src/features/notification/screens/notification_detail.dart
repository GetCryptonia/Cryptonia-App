import 'package:cryptonia/src/features/notification/provider/notification_provider.dart';
import 'package:cryptonia/src/features/notification/widgets/notification_detail_card.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationDetail extends StatefulWidget {
  const NotificationDetail({super.key});

  @override
  State<NotificationDetail> createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, notificationProv, _) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text('Notification Detail'),
          ),
          body: notificationProv.notification == null
              ? const Center(
                  child:
                      EmptyWidget(title: 'Oops!', body: 'Nothing to display.'),
                )
              : ListView(
                  padding: AppConstants.kScaffoldPadding,
                  children: [
                    NotificationDetailCard(
                      notification: notificationProv.notification!,
                    ),
                  ],
                ),
        );
      },
    );
  }
}
