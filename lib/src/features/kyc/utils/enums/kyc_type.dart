enum KycType { bvn, nin }

extension KycTypeExtension on KycType {
  String get value {
    switch (this) {
      case KycType.bvn:
        return 'BVN';
      case KycType.nin:
        return 'NIN';
    }
  }

  int get verification {
    switch (this) {
      case KycType.bvn:
        return 2;
      case KycType.nin:
        return 3;
    }
  }
}
