import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:cryptonia/src/shared/utils/date_time_utils.dart';
import 'package:cryptonia/src/shared/widgets/custom_button.dart';
import 'package:cryptonia/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ReportTransactionScreen extends StatefulWidget {
  const ReportTransactionScreen({super.key});

  @override
  State<ReportTransactionScreen> createState() =>
      _ReportTransactionScreenState();
}

class _ReportTransactionScreenState extends State<ReportTransactionScreen> {
  final TextEditingController _description = TextEditingController();
  final TextEditingController _hash = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Report Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.kContainerBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _breakdownRow(title: 'Transaction Type', value: 'Sell'),
                        const Divider(),
                        _breakdownRow(
                            title: 'Transaction ID',
                            value: '776fh5i48jjr58uf8473h'),
                        const Divider(),
                        _breakdownRow(title: 'Status', value: 'Expired'),
                        const Divider(),
                        _breakdownRow(title: 'Amount', value: '1700 USDT'),
                        const Divider(),
                        _breakdownRow(
                            title: 'Date',
                            value: DateTime.now().toReadableWithTime),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomRoundedTextField(
                    maxLines: 5,
                    controller: _description,
                    label: 'Enter a detailed description of the issue',
                  ),
                  const SizedBox(height: 16),
                  CustomRoundedTextField(
                    controller: _hash,
                    label: 'Enter Transaction Hash',
                  ),
                ],
              ),
            ),
            CustomButton(
              text: 'Submit',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _breakdownRow({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.kHintText),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.kFadedText),
            ),
          ),
        ],
      ),
    );
  }
}
