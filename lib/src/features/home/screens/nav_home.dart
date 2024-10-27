import 'package:cryptonia/src/features/history/screens/transaction_history_screen.dart';
import 'package:cryptonia/src/features/home/models/nav_item.dart';
import 'package:cryptonia/src/features/home/screens/home_screen.dart';
import 'package:cryptonia/src/features/profile/screens/edit_profile/profile_screen.dart';
import 'package:cryptonia/src/features/referral/referral_screen.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
