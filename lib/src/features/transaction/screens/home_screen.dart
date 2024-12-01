import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/history/providers/history_provider.dart';
import 'package:cryptonia/src/features/kyc/screens/verification_status.dart';
import 'package:cryptonia/src/features/kyc/utils/enums/kyc_type.dart';
import 'package:cryptonia/src/features/notification/screens/notification_list.dart';
import 'package:cryptonia/src/features/profile/providers/profile_provider.dart';
import 'package:cryptonia/src/features/transaction/providers/transaction_provider.dart';
import 'package:cryptonia/src/features/transaction/screens/select_bank.dart';
import 'package:cryptonia/src/features/transaction/utils/enums/transaction_status.dart';
import 'package:cryptonia/src/features/transaction/widgets/buy_sell_widget.dart';
import 'package:cryptonia/src/features/transaction/widgets/kyc_status_card.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionProvider>().fetchRatesLoop();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, transactionProv, _) {
        return Consumer<HistoryProvider>(
          builder: (context, historyProv, _) {
            return Consumer<ProfileProvider>(
              builder: (context, profileProv, _) {
                return Scaffold(
                  body: SafeArea(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 16, bottom: 32),
                          color: AppColors.kContainerBg,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text:
                                        'Welcome, ${profileProv.profile?.username ?? ""}\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: AppColors.kFadedText),
                                    children: [
                                      TextSpan(
                                        text: "Let's do business",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ]),
                              ),
                              InkWell(
                                onTap: () => PageNavigation.pushPage(
                                    context, const NotificationList()),
                                child: SvgPicture.asset(
                                    'assets/svgs/home/notification.svg',
                                    width: 20,
                                    height: 20),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  if (profileProv.profile?.kyc != KycType.bvn)
                                    KycStatusCard(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return const VerificationStatus();
                                            });
                                      },
                                      kycLevel: profileProv.profile?.kyc
                                              ?.verification(profileProv
                                                      .profile?.emailVerified ??
                                                  false) ??
                                          1,
                                      kycStatus: 'Your account is limited. '
                                          'Complete KYC for unlimited conversion.',
                                    ),
                                  const SizedBox(height: 16),
                                  BuySellWidget(
                                    exchange: () async {
                                      UiUtils.showLoadingIndicatorDialog(
                                          context);

                                      //fetch orders that are still processing and make sure it is empty
                                      final res =
                                          await historyProv.filterOrders(
                                              status:
                                                  TransactionStatus.processing);

                                      PageNavigation.popPage(context);

                                      if (res.status != Status.success) {
                                        UiUtils.displayResponse(context, res);
                                        return;
                                      }

                                      if (historyProv
                                          .filteredOrders.isNotEmpty) {
                                        UiUtils.showErrorDialog(context,
                                            description:
                                                'You have a pending order. '
                                                'Complete that order to create new ones.');
                                        return;
                                      }

                                      await PageNavigation.pushPage(
                                          context, const SelectBank());

                                      historyProv.filteredOrders = [];
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  // Container(
                                  //   height: 100,
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(7),
                                  //     image: const DecorationImage(
                                  //       fit: BoxFit.cover,
                                  //       image: AssetImage(
                                  //           'assets/images/home/referral.png'),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
