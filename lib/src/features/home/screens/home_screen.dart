import 'package:cryptonia/src/features/home/widgets/buy_sell_widget.dart';
import 'package:cryptonia/src/features/home/widgets/kyc_status_card.dart';
import 'package:cryptonia/src/features/kyc/screens/verification_status.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
                        text: 'Welcome, Temidayo\n',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.kFadedText),
                        children: [
                          TextSpan(
                            text: "Let's do business",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ]),
                  ),
                  SvgPicture.asset('assets/svgs/home/notification.svg',
                      width: 20, height: 20),
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
                      KycStatusCard(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return const VerificationStatus();
                              });
                        },
                        kycLevel: 1,
                        kycStatus: 'Your account is limited to \$100 '
                            'or 150,000 NGN worth of trade.',
                      ),
                      const SizedBox(height: 16),
                      const BuySellWidget(),
                      const SizedBox(height: 16),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                AssetImage('assets/images/home/referral.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
