import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class PickerHandler {
  final ImagePicker _imagePicker = ImagePicker();
  final FilePicker _filePicker = FilePicker.platform;

  // Method to pick a single image
  Future<XFile?> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: source);
      if (image != null) {
        return image;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error picking image: $e');
      }
    }
    return null;
  }

  // Method to pick a single video
  Future<XFile?> pickVideo(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickVideo(source: source);
      if (image != null) {
        return image;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error picking image: $e');
      }
    }
    return null;
  }

  // Method to pick a multi image
  Future<List<XFile>?> multiImages() async {
    try {
      List<XFile> listFiles = [];
      final List<XFile> selectedImages = await _imagePicker.pickMultiImage();
      if (selectedImages.isNotEmpty) {
        listFiles.addAll(selectedImages);
      }
      return listFiles;
    } catch (e) {
      if (kDebugMode) {
        print('Error picking image: $e');
      }
    }
    return null;
  }

  // Method to pick multiple files with extension filter
  Future<List<File>?> pickFiles({
    bool isMultiple = false,
    FileType fileType = FileType.any,
    List<String>? extensions
  }) async {
    try {
      final FilePickerResult? result = await _filePicker.pickFiles(
        allowMultiple: isMultiple,
        type: fileType,
        allowedExtensions: extensions
      );
      if (result != null) {
        return result.paths.map((path) => File(path!)).toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error picking files: $e');
      }
    }
    return null;
  }

}
