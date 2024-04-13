import 'package:path/path.dart' as p;

extension StringExtension on String {

  /// Get file extension from file path
  String getFileExtension() {
    String ext = p.extension(this);
    String fileExt = ext.substring(1, ext.length);
    return fileExt;
  }

  /// Get file name from file path
  String getFileName() {
    return p.basename(this);
  }

  String middleEllipsis(int maxLength) {
    // If the string is shorter than maxLength, return it as is.
    if (length <= maxLength) {
      return this;
    }

    // Calculate the number of characters to show before and after the ellipsis.
    int frontChars = (maxLength / 2).floor();
    int backChars = (maxLength / 2).ceil();

    // Return the truncated string with ellipsis in the middle.
    return '${substring(0, frontChars)}...${substring(length - backChars)}';
  }

}
