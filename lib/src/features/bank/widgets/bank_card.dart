import 'package:cryptonia/src/features/bank/models/account_model.dart';
import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BankCard extends StatelessWidget {
  final AccountModel account;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  const BankCard({
    super.key,
    required this.account,
    required this.onTap,
    required this.onDelete,
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
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          trailing: InkWell(
            onTap: onDelete,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.kContainerBg,
              child: SvgPicture.asset(
                'assets/svgs/profile/delete.svg',
                width: 24,
                height: 24,
                colorFilter:
                    ColorFilter.mode(AppColors.kTextColor, BlendMode.srcIn),
              ),
            ),
          ),
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
        ),
      ),
    );
  }
}
