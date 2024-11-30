import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/transaction/utils/enums/tokens_enum.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectCurrencyBottomSheet extends StatefulWidget {
  final Function(TokenType) onCurrencySelected;
  const SelectCurrencyBottomSheet(
      {super.key, required this.onCurrencySelected});

  @override
  State<SelectCurrencyBottomSheet> createState() =>
      _SelectCurrencyBottomSheetState();
}

class _SelectCurrencyBottomSheetState extends State<SelectCurrencyBottomSheet> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<TokenType> tokens = _searchController.text.isEmpty
        ? TokenType.values
        : TokenType.values
            .where((e) =>
                e.label
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()) ||
                e.network
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()))
            .toList();

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
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
                const Text('Select Currency'),
                const SizedBox(width: 30),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomRoundedTextField(
              controller: _searchController,
              hint: 'Search Currency',
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
              itemCount: tokens.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    widget.onCurrencySelected(tokens[index]);
                    PageNavigation.popPage(context);
                  },
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  leading: CircleAvatar(
                    radius: 12,
                    backgroundImage: AssetImage(tokens[index].asset),
                  ),
                  title: Text(
                    tokens[index].label,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Text(
                    tokens[index].network,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.kHintText),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
