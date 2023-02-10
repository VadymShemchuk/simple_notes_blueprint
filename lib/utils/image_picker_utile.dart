import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerUtil {
  ImagePickerUtil._();
  static ImagePicker get _imagePicker => ImagePicker();

  static Future<File?> getImageFrom(ImageSource sourse) async {
    XFile? pickedFile;
    File imageFile;

    switch (sourse) {
      case ImageSource.gallery:
        pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
        break;
      case ImageSource.camera:
        pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
        break;
    }
    if (pickedFile == null) {
      return null;
    } else {
      imageFile = File(pickedFile.path);
      return imageFile;
    }
  }
}
