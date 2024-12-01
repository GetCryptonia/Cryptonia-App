extension StringExtension on String {
//to censored address like 0x1234...5678
  String censoredAddress() {
    return '${substring(0, 6)}...${substring(length - 4, length)}';
  }
}
