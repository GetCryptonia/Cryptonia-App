import 'package:cryptonia/src/features/notification/widgets/notification_detail_card.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:flutter/material.dart';

class NotificationDetail extends StatefulWidget {
  const NotificationDetail({super.key});

  @override
  State<NotificationDetail> createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Notification Detail'),
      ),
      body: ListView(
        padding: AppConstants.kScaffoldPadding,
        children: [
          NotificationDetailCard(),
        ],
      ),
    );
  }
}
