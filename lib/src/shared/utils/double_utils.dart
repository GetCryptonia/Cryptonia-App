extension DoubleExtension on double {
  String get toReadable {
    //add commas to large numbers
    return toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }
}
