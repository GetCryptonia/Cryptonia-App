import 'package:cryptonia/src/features/history/screens/transaction_history_screen.dart';
import 'package:cryptonia/src/features/home/models/nav_item.dart';
import 'package:cryptonia/src/features/notification/provider/notification_provider.dart';
import 'package:cryptonia/src/features/profile/screens/profile_screen.dart';
import 'package:cryptonia/src/features/referral/referral_screen.dart';
import 'package:cryptonia/src/features/transaction/screens/home_screen.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NavHome extends StatefulWidget {
  const NavHome({super.key});

  @override
  State<NavHome> createState() => _NavHomeState();
}

class _NavHomeState extends State<NavHome> {
  int selectedIndex = 0;
  final List<NavItem> _items = [
    NavItem(
      label: 'Home',
      activeIcon: 'assets/svgs/home/filled/home.svg',
      passiveIcon: 'assets/svgs/home/outlined/home.svg',
      page: const HomeScreen(),
    ),
    NavItem(
      label: 'History',
      activeIcon: 'assets/svgs/home/filled/history.svg',
      passiveIcon: 'assets/svgs/home/outlined/history.svg',
      page: const TransactionHistoryScreen(),
    ),
    NavItem(
      label: 'Referral',
      activeIcon: 'assets/svgs/home/filled/referral.svg',
      passiveIcon: 'assets/svgs/home/outlined/referral.svg',
      page: const ReferralScreen(),
    ),
    NavItem(
      label: 'More',
      activeIcon: 'assets/svgs/home/filled/more.svg',
      passiveIcon: 'assets/svgs/home/outlined/more.svg',
      page: const ProfileScreen(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    getFcmToken();
  }

  void getFcmToken() async {
    final notificationSettings =
        await FirebaseMessaging.instance.requestPermission(provisional: true);
    // For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
    final apnsToken = await FirebaseMessaging.instance.getToken();

    print('Token: $apnsToken');

    if (apnsToken == null) return;

    final res = await context.read<NotificationProvider>().editToken(apnsToken);

    print('Response: ${res.message}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _items[selectedIndex].page,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: _items.map((item) {
            return BottomNavigationBarItem(
              activeIcon: Container(
                width: 52,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.kNavBarSelected,
                  borderRadius: BorderRadius.circular(128),
                ),
                child: Center(
                  child:
                      SvgPicture.asset(item.activeIcon, width: 20, height: 20),
                ),
              ),
              icon: SvgPicture.asset(item.passiveIcon, width: 20, height: 20),
              label: item.label,
            );
          }).toList()),
    );
  }
}
