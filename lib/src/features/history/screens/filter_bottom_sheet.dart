import 'package:cryptonia/src/core/local/page_navigation.dart';
import 'package:cryptonia/src/features/transaction/utils/enums/transaction_status.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/app_constants.dart';
import 'package:cryptonia/src/shared/utils/date_time_utils.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final TextEditingController _start = TextEditingController();
  final TextEditingController _end = TextEditingController();
  List<TransactionStatus> statuses = TransactionStatus.values.toList();
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => PageNavigation.popPage(context),
                  icon: const Icon(Icons.arrow_back),
                ),
                const Text(
                  'Filter',
                  textAlign: TextAlign.left,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.check),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Status'),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...TransactionStatus.values.map((status) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CustomButton(
                            borderRadius: 128,
                            text: status.label,
                            color: Colors.transparent,
                            borderColor: statuses.contains(status)
                                ? AppColors.kPrimary
                                : AppColors.kHintText,
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: statuses.contains(status)
                                        ? AppColors.kPrimary
                                        : AppColors.kHintText),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            onPressed: () {
                              setState(() {
                                statuses.contains(status)
                                    ? statuses.remove(status)
                                    : statuses.add(status);
                              });
                            },
                          ),
                        );
                      })
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Start Date'),
                          const SizedBox(height: 8),
                          CustomRoundedTextField(
                            onTap: () async {
                              DateTime? date = await showDatePicker(
                                context: context,
                                firstDate: DateTime(2024, 10, 1),
                                lastDate: DateTime.now(),
                              );

                              if (date == null) return;

                              setState(() {
                                startDate = date;
                                AppConstants.setTextFieldValue(
                                    controller: _start,
                                    text: date.toReadableDate);
                              });
                            },
                            controller: _start,
                            hint: 'Select date',
                            readOnly: true,
                            suffixIcon: const Icon(
                              Icons.calendar_month_rounded,
                              color: AppColors.kHintText,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('End Date'),
                          const SizedBox(height: 8),
                          CustomRoundedTextField(
                            onTap: () async {
                              DateTime? date = await showDatePicker(
                                context: context,
                                firstDate: DateTime(2024, 10, 1),
                                lastDate: DateTime.now(),
                              );

                              if (date == null) return;

                              setState(() {
                                startDate = date;
                                AppConstants.setTextFieldValue(
                                    controller: _end,
                                    text: date.toReadableDate);
                              });
                            },
                            controller: _end,
                            hint: 'Select date',
                            readOnly: true,
                            suffixIcon: const Icon(
                              Icons.calendar_month_rounded,
                              color: AppColors.kHintText,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                CustomButton(
                  text: 'Confirm',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
