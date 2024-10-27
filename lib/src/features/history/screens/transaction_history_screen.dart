import 'package:cryptonia/src/features/history/screens/filter_bottom_sheet.dart';
import 'package:cryptonia/src/features/history/widgets/transaction_history_category.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/widgets/custom_text_field.dart';
import 'package:cryptonia/src/shared/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  bool empty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
            onTap: () {
              setState(() {
                empty = !empty;
              });
            },
            child: const Text('Transaction History')),
        backgroundColor: AppColors.kContainerBg,
      ),
      body: empty
          ? const Center(
              child: EmptyWidget(
                  image: 'assets/images/history/search.png',
                  title: 'Nothing to see yet',
                  body: 'You are yet to complete your first trade.'),
            )
          : Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomRoundedTextField(
                          hint: 'Search for transactions',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12),
                            child: SvgPicture.asset(
                              width: 13,
                              height: 13,
                              'assets/svgs/history/search-line.svg',
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return const FilterBottomSheet();
                              });
                        },
                        icon: SvgPicture.asset(
                          width: 24,
                          height: 24,
                          'assets/svgs/history/filter.svg',
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      TransactionHistoryCategory(
                        date: DateTime.now(),
                      ),
                      TransactionHistoryCategory(
                        date: DateTime.now().subtract(const Duration(days: 1)),
                      ),
                      TransactionHistoryCategory(
                        date: DateTime.now().subtract(const Duration(days: 6)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
