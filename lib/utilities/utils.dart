import 'dart:typed_data';
import 'package:autismcompanionsupport/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

const double baseHeight = 650.0;

Future<Map<String, dynamic>?> pickImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  final XFile? file = await picker.pickImage(source: source);

  if (file != null) {
    final Uint8List imageBytes = await file.readAsBytes();
    return {
      'path': file.path, 
      'bytes': imageBytes 
    };
  }
  return null;
}

Divider customDivider() {
  return const Divider(
    color: AppColors.switchGreyColor,  // Line color
    thickness: 1,        // Line thickness
  );
}

double screenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseHeight;
}

Future<CroppedFile?> cropImage(String pickedFile) async {
    return await ImageCropper().cropImage(
      sourcePath: pickedFile,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPresetCustom(),
          ],
        ),
      ],
    );
  }

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}