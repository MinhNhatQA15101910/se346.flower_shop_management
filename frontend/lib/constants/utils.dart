import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

Future<List<File>> pickImages(List<File> currentImages) async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (files != null && files.files.isNotEmpty) {
      for (var f in files.files) {
        images.add(File(f.path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  return images.isEmpty ? currentImages : images;
}

Future<File?> pickOneImage() async {
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (files != null && files.files.isNotEmpty) {
      for (var f in files.files) {
        return File(f.path!);
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  return null;
}
