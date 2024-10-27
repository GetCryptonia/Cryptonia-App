import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:flutter/material.dart';

class SelectBankCard extends StatelessWidget {
  final String image;
  final String bankName;
  final String accountName;
  final String accountNumber;
  final VoidCallback onTap;
  final bool selected;
  const SelectBankCard({
    super.key,
    required this.image,
    required this.bankName,
    required this.accountName,
    required this.accountNumber,
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
          leading: CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(image),
          ),
          title: Text(accountName),
          subtitle: Row(
            children: [
              Text(
                accountNumber,
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
              Text(
                bankName,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.kHintText),
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
