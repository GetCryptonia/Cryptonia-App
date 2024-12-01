enum Currency { ngn }

extension CurrencyTypeExtension on Currency {
  String get asset {
    switch (this) {
      case Currency.ngn:
        return 'assets/images/tokens/ngn.png';
    }
  }

  String get symbol {
    switch (this) {
      case Currency.ngn:
        return 'NGN';
    }
  }

  String get label {
    switch (this) {
      case Currency.ngn:
        return 'Naira';
    }
  }
}
