import 'package:cryptonia/src/shared/theming/app_theming.dart';
import 'package:flutter/material.dart';

enum TransactionStatus { processing, successful, expired }

extension TransactionStatusEnum on TransactionStatus {
  String get label {
    switch (this) {
      case TransactionStatus.processing:
        return 'Processing';
      case TransactionStatus.successful:
        return 'Successful';
      case TransactionStatus.expired:
        return 'Expired';
    }
  }

  Icon get icon {
    switch (this) {
      case TransactionStatus.processing:
        return const Icon(Icons.access_time_filled_rounded,
            size: 20, color: AppColors.kYellowProcessing);
      case TransactionStatus.successful:
        return const Icon(Icons.check_circle,
            size: 20, color: AppColors.kGreenCheck);
      case TransactionStatus.expired:
        return const Icon(Icons.info, size: 20, color: AppColors.kRedCross);
    }
  }
}
