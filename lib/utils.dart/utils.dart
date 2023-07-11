// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// for picking up image from gallery
pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No Image Selected');
}
pickMultipleImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  List<Uint8List> uploadedImageList = [];
  List<XFile> _fileList = await _imagePicker.pickMultiImage();

  int length = _fileList.length > 5 ? 5 : _fileList.length;

  if (uploadedImageList.isNotEmpty) {
    print('No Image Selected');
  }

  for(int i= 0; i <length; i++){
    uploadedImageList.add(await _fileList[i].readAsBytes());
  }

  return uploadedImageList;

}


showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
