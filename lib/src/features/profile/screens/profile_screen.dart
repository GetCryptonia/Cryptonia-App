import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/auth/screens/sign_in.dart';
import 'package:cryptonia/src/features/bank/providers/bank_provider.dart';
import 'package:cryptonia/src/features/bank/screens/bank_list_screen.dart';
import 'package:cryptonia/src/features/history/providers/history_provider.dart';
import 'package:cryptonia/src/features/kyc/provider/kyc_provider.dart';
import 'package:cryptonia/src/features/kyc/screens/verification_status.dart';
import 'package:cryptonia/src/features/kyc/utils/enums/kyc_type.dart';
import 'package:cryptonia/src/features/notification/provider/notification_provider.dart';
import 'package:cryptonia/src/features/profile/providers/profile_provider.dart';
import 'package:cryptonia/src/features/profile/screens/about_us/about_us.dart';
import 'package:cryptonia/src/features/profile/screens/edit_profile/personal_information_screen.dart';
import 'package:cryptonia/src/features/profile/screens/help_and_support/help_and_support.dart';
import 'package:cryptonia/src/features/profile/widgets/profile_action_tile.dart';
import 'package:cryptonia/src/features/profile/widgets/profile_card.dart';
import 'package:cryptonia/src/features/transaction/providers/transaction_provider.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/widgets/api_response_future_builder.dart';
import 'package:cryptonia/src/shared/widgets/confirmation_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<ApiResponse> _future;

  @override
  void initState() {
    super.initState();
    _future = context.read<ProfileProvider>().getAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('More'),
        backgroundColor: AppColors.kContainerBg,
      ),
      body: ApiResponseFutureBuilder(
        future: _future,
        child: Consumer<ProfileProvider>(
          builder: (context, profileProv, _) {
            return ListView(
              padding: AppConstants.kScaffoldPadding,
              children: [
                const SizedBox(height: 16),
                ProfileCard(
                  avatar: profileProv.profile?.avatar ??
                      'assets/images/avatars/1.png',
                  email: profileProv.profile?.email ?? 'Email',
                  username: profileProv.profile?.username ?? 'Username',
                  avatarTap: () {},
                  editTap: () {
                    PageNavigation.pushPage(
                        context, const PersonalInformationScreen());
                  },
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.kContainerBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ProfileActionTile(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return const VerificationStatus();
                              });
                        },
                        icon: 'assets/svgs/profile/verification.svg',
                        title: 'Verification',
                        trailingPrefix: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.kPrimary,
                              borderRadius: BorderRadius.circular(128),
                            ),
                            child: Text(
                                '${profileProv.profile?.kyc?.verification ?? 1}/${KycType.values.length} Completed'),
                          ),
                        ),
                      ),
                      ProfileActionTile(
                        onTap: () => PageNavigation.pushPage(
                            context, const BankListScreen()),
                        icon: 'assets/svgs/profile/bank.svg',
                        title: 'Bank Account',
                      ),
                      // ProfileActionTile(
                      //   onTap: () => PageNavigation.pushPage(
                      //       context, const SecurityScreen()),
                      //   icon: 'assets/svgs/profile/security.svg',
                      //   title: 'Security',
                      // ),
                      ProfileActionTile(
                        onTap: () {
                          PageNavigation.pushPage(
                              context, const HelpAndSupport());
                        },
                        icon: 'assets/svgs/profile/support.svg',
                        title: 'Help & Support',
                      ),
                      ProfileActionTile(
                        onTap: () {
                          PageNavigation.pushPage(context, const AboutUs());
                        },
                        icon: 'assets/svgs/profile/about.svg',
                        title: 'Legal',
                      ),
                      ProfileActionTile(
                        onTap: () {},
                        icon: 'assets/svgs/profile/rate.svg',
                        title: 'Rate Us',
                        trailingIcon: 'assets/svgs/profile/link.svg',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.kContainerBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ProfileActionTile(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ConfirmationBottomSheet(
                          message: 'Are you sure you want to sign out?',
                          onTap: () async {
                            //clear all and replace page with the login screen and pop all stack

                            context.read<TransactionProvider>().clearAll();
                            context.read<HistoryProvider>().clearAll();
                            context.read<NotificationProvider>().clearAll();
                            context.read<KycProvider>().clearAll();
                            context.read<BankProvider>().clearAll();

                            PageNavigation.replaceAll(context, const SignIn());
                          },
                        );
                      },
                    ),
                    title: 'Sign Out',
                    trailingIcon: null,
                    iconColor: AppColors.kRedCross,
                    icon: 'assets/svgs/profile/sign-out.svg',
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
