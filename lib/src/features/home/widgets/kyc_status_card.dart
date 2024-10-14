import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KycStatusCard extends StatelessWidget {
  final int kycLevel;
  final String kycStatus;
  final VoidCallback onTap;
  const KycStatusCard({
    super.key,
    required this.kycLevel,
    required this.kycStatus,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.kNavBarSelected,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(128),
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        AppColors.kPrimaryGradient1,
                        AppColors.kPrimaryGradient2,
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset('assets/svgs/home/medal-line.svg',
                          width: 8, height: 10),
                      const SizedBox(width: 6),
                      Text('$kycLevel/4 Completed',
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  'KYC Verification',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward, size: 17),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              kycStatus,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.kFadedText),
            )
          ],
        ),
      ),
    );
  }
}
