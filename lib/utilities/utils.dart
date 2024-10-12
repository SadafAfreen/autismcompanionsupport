import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

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

