import 'package:cryptonia/src/core/enums/tokens_enum.dart';
import 'package:cryptonia/src/features/transaction/screens/select_currency_bottom_sheet.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class BuySellWidget extends StatefulWidget {
  final VoidCallback exchange;
  const BuySellWidget({super.key, required this.exchange});

  @override
  State<BuySellWidget> createState() => _BuySellWidgetState();
}

class _BuySellWidgetState extends State<BuySellWidget> {
  TokenType haveToken = TokenType.btc;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kTextField,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CustomButton(
              onPressed: () {},
              text: 'Sell Crypto',
              textStyle: Theme.of(context).textTheme.bodySmall,
              borderRadius: 128,
              color: AppColors.kPrimary,
              padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            decoration: const BoxDecoration(
              color: AppColors.kScaffold,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'I have',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                          text: '0 ',
                          style: Theme.of(context).textTheme.headlineSmall,
                          children: [
                            TextSpan(
                              text: '(~\$0)',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.kHintText),
                            )
                          ]),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return SelectCurrencyBottomSheet(
                              onCurrencySelected: (currency) {
                            setState(() {
                              haveToken = currency;
                            });
                          });
                        });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.kTextField,
                      borderRadius: BorderRadius.circular(128),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 9,
                          backgroundImage: AssetImage(haveToken.asset),
                          backgroundColor: AppColors.kScaffold,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          haveToken.label,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.keyboard_arrow_down_rounded, size: 17)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            decoration: const BoxDecoration(
              color: AppColors.kScaffold,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'I need',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '0.00',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.kTextField,
                    borderRadius: BorderRadius.circular(128),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 9,
                        backgroundImage: AssetImage(TokenType.ngn.asset),
                        backgroundColor: AppColors.kScaffold,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        TokenType.ngn.label,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                'Rate',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.kHintText),
              ),
              const Spacer(),
              Text(
                '1 Eth = 1,700,000.00 NGN',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.kHintText),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                'Fee',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.kHintText),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.info_outline,
                size: 13,
                color: AppColors.kHintText,
              ),
              const Spacer(),
              Text(
                '\$1',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.kHintText),
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Exchange',
            onPressed: widget.exchange,
          ),
        ],
      ),
    );
  }
}
