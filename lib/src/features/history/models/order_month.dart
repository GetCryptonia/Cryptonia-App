class OrderMonth {
  int month;
  int year;

  OrderMonth({
    required this.month,
    required this.year,
  });

  static OrderMonth fromDate(DateTime date) {
    return OrderMonth(month: date.month, year: date.year);
  }

  DateTime get toDate => DateTime(year, month);
}
