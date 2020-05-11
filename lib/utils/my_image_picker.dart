import 'dart:io';

import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class MyImagePicker {
  static Future<File> pickImage() async {
    File image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return null;

    File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path,
        maxHeight: 1000,
        maxWidth: 1000,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
    return croppedImage;
  }

  static Future<File> thumbnail(File imageFile) async {
    if (imageFile == null) return null;

    return FlutterNativeImage.compressImage(imageFile.path,
        targetWidth: 120, targetHeight: 120);
  }
}
