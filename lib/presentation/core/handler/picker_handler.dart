import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class PickerHandler {
  final ImagePicker _imagePicker = ImagePicker();
  final FilePicker _filePicker = FilePicker.platform;

  // Method to pick a single image
  Future<File?> pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        return File(image.path);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
    return null;
  }

  // Method to pick multiple files with extension filter
  Future<List<File>?> pickFiles() async {
    try {
      final FilePickerResult? result = await _filePicker.pickFiles(allowMultiple: true);
      if (result != null) {
        return result.paths.map((path) => File(path!)).toList();
      }
    } catch (e) {
      print('Error picking files: $e');
    }
    return null;
  }

// Add more methods for other picker types if needed (e.g., picking directories)

// Example usage:
// final pickerHandler = PickerHandler();
// final pickedImage = await pickerHandler.pickImage();
// final pickedFiles = await pickerHandler.pickFiles();
}
