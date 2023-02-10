class DateUtil {
  static String getFormatedDate() {
    final date = DateTime.now();
    final year = date.year;
    final month = date.month;
    final day = date.day;
    String actualDate = '$day $month $year';

    return actualDate;
  }
}
