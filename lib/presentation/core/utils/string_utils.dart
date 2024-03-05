class StringUtils {

  String convertToTitleCase(String input) {
    // Use regular expression to match camelCase or underscore_case
    RegExp regex = RegExp(r'(?<=[a-z])[A-Z]|[_]');

    // Replace matches with space and capitalize the first letter
    String result = input.replaceAllMapped(regex, (match) {
      return match.group(0) == '_' ? ' ' : ' ${match.group(0)}';
    }).trim();

    // Capitalize the first letter of the string
    result = result.substring(0, 1).toUpperCase() + result.substring(1);

    return result;
  }

}