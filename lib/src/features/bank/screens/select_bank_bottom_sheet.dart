import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/core/network/api_response.dart';
import 'package:cryptonia/src/features/bank/models/bank_model.dart';
import 'package:cryptonia/src/features/bank/providers/bank_provider.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/widgets/api_response_future_builder.dart';
import 'package:cryptonia/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SelectBankBottomSheet extends StatefulWidget {
  final Function(BankModel) onBankSelected;
  const SelectBankBottomSheet({super.key, required this.onBankSelected});

  @override
  State<SelectBankBottomSheet> createState() => _SelectBankBottomSheetState();
}

class _SelectBankBottomSheetState extends State<SelectBankBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  late Future<ApiResponse> _future;

  @override
  void initState() {
    super.initState();
    _future = context.read<BankProvider>().fetchBanks();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: ApiResponseFutureBuilder(
        future: _future,
        child: Consumer<BankProvider>(
          builder: (context, bankProv, _) {
            List<BankModel> banks = _searchController.text.isEmpty
                ? bankProv.banks
                : bankProv.banks
                    .where((e) => e.name
                        .toLowerCase()
                        .contains(_searchController.text.toLowerCase()))
                    .toList();

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.kContainerBg,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => PageNavigation.popPage(context),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const Text('Select Bank'),
                      const SizedBox(width: 30),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomRoundedTextField(
                    controller: _searchController,
                    hint: 'Search Bank',
                    onChanged: (val) {
                      setState(() {});
                    },
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
                const SizedBox(height: 8),
                const Divider(),
                Expanded(
                  child: ListView.separated(
                    itemCount: banks.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          widget.onBankSelected(banks[index]);
                          PageNavigation.popPage(context);
                        },
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        leading: CircleAvatar(
                          radius: 12,
                          backgroundColor: AppColors.kContainerBg,
                          child:
                              SvgPicture.asset('assets/svgs/profile/bank.svg'),
                        ),
                        title: Text(
                          banks[index].name,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
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
