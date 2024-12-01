import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/history/models/order_model.dart';
import 'package:cryptonia/src/features/transaction/providers/transaction_provider.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/utils/num_extension.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class OrderCompleted extends StatefulWidget {
  const OrderCompleted({super.key});

  @override
  State<OrderCompleted> createState() => _OrderCompletedState();
}

class _OrderCompletedState extends State<OrderCompleted> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, transactionProv, _) {
        OrderModel? order = transactionProv.sellOrder;

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Order Completed'),
            backgroundColor: AppColors.kContainerBg,
          ),
          body: order == null
              ? const Center(
                  child: EmptyWidget(
                    title: 'Oops!',
                    body: "Could not fetch order details. "
                        "Don't worry your order is processing "
                        "in the background.",
                  ),
                )
              : Padding(
                  padding: AppConstants.kScaffoldPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(32),
                              decoration: BoxDecoration(
                                color: AppColors.kContainerBg,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      'assets/svgs/history/checkbox-circle-fill.svg',
                                      width: 56,
                                      height: 56),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Exchange Complete',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    '${order.fiatAmount.toReadable} NGN',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 32),
                                  Text(
                                    'Check your bank account',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: AppColors.kPrimary),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${order.receiverAccountNumber} · ${order.receiverBank}',
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: AppColors.kHintText),
                                  ),
                                ],
                              ),
                            ),
                            // const SizedBox(height: 16),
                            // GestureDetector(
                            //   onTap: () => PageNavigation.pushPage(
                            //       context, const RateExperience()),
                            //   child: Container(
                            //     padding: const EdgeInsets.all(32),
                            //     decoration: BoxDecoration(
                            //       color: AppColors.kContainerBg,
                            //       borderRadius: BorderRadius.circular(8),
                            //     ),
                            //     child: Column(
                            //       mainAxisSize: MainAxisSize.min,
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       children: [
                            //         Text(
                            //           'Rate your experience',
                            //           style: Theme.of(context)
                            //               .textTheme
                            //               .bodyMedium
                            //               ?.copyWith(
                            //                   fontWeight: FontWeight.bold),
                            //         ),
                            //         const SizedBox(height: 24),
                            //         //a row of five outline stars with a space of 8 between each star and hint color
                            //         Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.center,
                            //           children: List.generate(
                            //             5,
                            //             (index) => const Padding(
                            //               padding: EdgeInsets.only(right: 8),
                            //               child: Icon(
                            //                   Icons.star_border_outlined,
                            //                   color: AppColors.kHintText),
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      CustomButton(
                        text: 'Go back',
                        onPressed: () {
                          PageNavigation.popPage(context, 4);
                        },
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}
