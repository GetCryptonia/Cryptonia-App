import 'package:cryptonia/src/features/bank/models/account_model.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:flutter/material.dart';

class SelectBankCard extends StatelessWidget {
  final AccountModel account;
  final VoidCallback onTap;
  final bool selected;
  const SelectBankCard({
    super.key,
    required this.account,
    required this.onTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.kContainerBg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          onTap: onTap,
          title: Text(
            account.accountName,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          subtitle: Row(
            children: [
              Text(
                account.accountNumber,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.kHintText),
              ),
              const SizedBox(width: 8),
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                    color: AppColors.kPrimary, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  account.bankName,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.kHintText),
                ),
              ),
            ],
          ),
          trailing: Icon(
            selected ? Icons.check_circle : Icons.circle_outlined,
            size: 23,
            color: selected ? AppColors.kGreenCheck : AppColors.kHintText,
          ),
        ),
      ),
    );
  }
}
