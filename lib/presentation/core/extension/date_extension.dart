import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  // Check if the current date is after the provided date.
  bool isAfterDate(DateTime other) => isAfter(DateTime(other.year, other.month, other.day));

  // Check if the current date is before the provided date.
  bool isBeforeDate(DateTime other) => isBefore(DateTime(other.year, other.month, other.day));

  // Check if the current date is the same day as the provided date.
  bool isSameDate(DateTime other) => year == other.year && month == other.month && day == other.day;

  // Add days to the current date.
  DateTime addDays(int days) => add(Duration(days: days));

  // Subtract days from the current date.
  DateTime subtractDays(int days) => subtract(Duration(days: days));

  // Get the first day of the month.
  DateTime get firstDayOfMonth => DateTime(year, month);

  // Get the last day of the month.
  DateTime get lastDayOfMonth => DateTime(year, month + 1).subtract(const Duration(days: 1));

  // Format the date as a string in the format 'yyyy-MM-dd'.
  String toFormattedString() => "${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";

  // Get the number of days in the current month.
  int get daysInMonth => lastDayOfMonth.day;

  // Get the day of the week as a string.
  String get dayOfWeek => ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'][weekday - 1];

  // Check if the year is a leap year.
  bool get isLeapYear => (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

  // Get the week of the year.
  int get weekOfYear {
    int dayOfYear = int.parse(DateFormat('D').format(this));
    return ((dayOfYear - weekday + 10) / 7).floor();
  }

  // Get the age from a birth date.
  int get age {
    DateTime today = DateTime.now();
    int age = today.year - year;
    if (today.month < month || (today.month == month && today.day < day)) {
      age--;
    }
    return age;
  }

  // Get a DateTime object with only the date part (time set to 00:00:00).
  DateTime get dateOnly => DateTime(year, month, day);
}
