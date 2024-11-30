import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/history/models/order_model.dart';
import 'package:cryptonia/src/features/history/models/order_month.dart';
import 'package:cryptonia/src/features/history/providers/history_provider.dart';
import 'package:cryptonia/src/features/history/screens/filter_bottom_sheet.dart';
import 'package:cryptonia/src/features/history/widgets/transaction_history_category.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/widgets/api_response_future_builder.dart';
import 'package:cryptonia/src/shared/widgets/custom_text_field.dart';
import 'package:cryptonia/src/shared/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final TextEditingController _search = TextEditingController();
  late Future<ApiResponse> _future;

  @override
  void initState() {
    super.initState();
    _future = context.read<HistoryProvider>().fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Transaction History'),
        backgroundColor: AppColors.kContainerBg,
      ),
      body: ApiResponseFutureBuilder(
        future: _future,
        child: Consumer<HistoryProvider>(
          builder: (context, historyProv, _) {
            List<OrderModel> orders = _search.text.isNotEmpty
                ? historyProv.orders
                    .where((e) =>
                        e.receiverAccountName
                            .toLowerCase()
                            .contains(_search.text.toLowerCase().trim()) ||
                        e.receiverAccountNumber
                            .toLowerCase()
                            .contains(_search.text.toLowerCase().trim()) ||
                        e.receiverBank
                            .toLowerCase()
                            .contains(_search.text.toLowerCase().trim()) ||
                        e.address
                            .toLowerCase()
                            .contains(_search.text.toLowerCase().trim()) ||
                        e.status.name
                            .toLowerCase()
                            .contains(_search.text.toLowerCase().trim()))
                    .toList()
                : historyProv.filteredOrders.isEmpty
                    ? historyProv.orders
                    : historyProv.filteredOrders;
            List<OrderMonth> months = historyProv.orderDates(orders);

            if (historyProv.orders.isEmpty) {
              return const Center(
                child: EmptyWidget(
                    image: 'assets/images/history/search.png',
                    title: 'Nothing to see yet',
                    body: 'You are yet to complete your first trade.'),
              );
            }

            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomRoundedTextField(
                          controller: _search,
                          hint: 'Search for transactions',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12),
                            child: SvgPicture.asset(
                              width: 13,
                              height: 13,
                              'assets/svgs/history/search-line.svg',
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {});
                          },
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
                  child: ListView.builder(
                    itemCount: months.length,
                    itemBuilder: (context, index) {
                      return TransactionHistoryCategory(
                        date: months[index].toDate,
                        orders: orders
                            .where((e) =>
                                e.createdAt.year == months[index].year &&
                                e.createdAt.month == months[index].month)
                            .toList(),
                      );
                    },
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
