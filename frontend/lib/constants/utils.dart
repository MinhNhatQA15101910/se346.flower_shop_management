import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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
