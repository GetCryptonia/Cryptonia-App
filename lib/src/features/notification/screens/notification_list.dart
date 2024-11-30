import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/notification/provider/notification_provider.dart';
import 'package:cryptonia/src/features/notification/screens/notification_detail.dart';
import 'package:cryptonia/src/features/notification/widgets/notification_card.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/utils/ui_utils.dart';
import 'package:cryptonia/src/shared/widgets/api_response_future_builder.dart';
import 'package:cryptonia/src/shared/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  late Future<ApiResponse> _future;

  @override
  void initState() {
    super.initState();
    _future = context.read<NotificationProvider>().fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Notifications'),
        actions: [
          IconButton(
            onPressed: () async {
              UiUtils.showLoadingIndicatorDialog(context);
              await context.read<NotificationProvider>().markAllAsRead();
              PageNavigation.popPage(context);
            },
            icon: SvgPicture.asset(
              'assets/svgs/notification/check-double-line.svg',
              width: 24,
              height: 24,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _future = context.read<NotificationProvider>().fetchNotifications();
          });
        },
        child: ApiResponseFutureBuilder(
          future: _future,
          child: Consumer<NotificationProvider>(
            builder: (context, notificationProv, _) {
              if (notificationProv.notifications.isEmpty) {
                return const Center(
                  child: EmptyWidget(
                    image: 'assets/images/notification/notification-empty.png',
                    title: 'You are updated',
                    body: 'You do not have any\nnotification.',
                  ),
                );
              } else {
                return ListView.builder(
                  padding: AppConstants.kScaffoldPadding,
                  itemCount: notificationProv.notifications.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: NotificationCard(
                        notification: notificationProv.notifications[index],
                        onTap: () {
                          notificationProv.notification =
                              notificationProv.notifications[index];
                          PageNavigation.pushPage(
                            context,
                            const NotificationDetail(),
                          );
                        },
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
