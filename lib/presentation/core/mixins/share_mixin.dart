import 'package:share_plus/share_plus.dart';

mixin ShareMixin {

  // Method to share text content
  void shareText(String text) {
    Share.share(text);
  }

  // Method to share one or multiple files
  Future<void> shareFiles(List<XFile> files, {required String text, required String subject}) async {
    final result = await Share.shareXFiles(files, text: text, subject: subject);
    if (result.status == ShareResultStatus.success) {
      print('Content shared successfully!');
    } else if (result.status == ShareResultStatus.dismissed) {
      print('User dismissed the share sheet.');
    }
  }

}
