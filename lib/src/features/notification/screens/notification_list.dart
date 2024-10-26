import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/notification/screens/notification_detail.dart';
import 'package:cryptonia/src/features/notification/widgets/notification_card.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  bool isEmpty = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Notifications'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isEmpty = !isEmpty;
              });
            },
            icon: SvgPicture.asset(
              'assets/svgs/notification/check-double-line.svg',
              width: 24,
              height: 24,
            ),
          )
        ],
      ),
      body: isEmpty
          ? Center(
              child: EmptyWidget(
                image: 'assets/images/notification/notification-empty.png',
                title: 'You are updated',
                body: 'You do not have any\nnotification.',
              ),
            )
          : ListView(
              padding: AppConstants.kScaffoldPadding,
              children: [
                NotificationCard(
                  onTap: () {
                    PageNavigation.pushPage(
                        context, const NotificationDetail());
                  },
                ),
              ],
            ),
    );
  }
}
