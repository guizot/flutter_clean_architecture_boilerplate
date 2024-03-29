class DateTimeUtils {

  List<String> generatePastYearsList(int numYears) {
    final currentYear = DateTime.now().year;
    return List.generate(numYears, (index) => (currentYear - index).toString());
  }

}