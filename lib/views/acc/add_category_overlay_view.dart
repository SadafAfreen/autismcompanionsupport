import 'dart:developer';
import 'dart:io';

//import 'package:flutter_sound/flutter_sound.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:record/record.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path/path.dart' as p;

import 'package:autismcompanionsupport/utilities/utils.dart';
import 'package:autismcompanionsupport/views/acc/category.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCategoryOverlay extends StatefulWidget {
  final Function(CategoryModel) onAddCategory;

  const AddCategoryOverlay({
    super.key, 
    required this.onAddCategory, 
  });

  @override
  State<AddCategoryOverlay> createState() => _AddCategoryOverlayState();
}

class _AddCategoryOverlayState extends State<AddCategoryOverlay> {
  final TextEditingController _nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  File? _audioFile;
  String? _errorText;

  //final AudioRecorder _audioRecorder = AudioRecorder();
  bool isRecording = false;
  //String? _audioFilePath;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      final croppedFile = await cropImage(_imageFile!.path);
      if(croppedFile != null) {
        setState(() {
          _imageFile = File(croppedFile.path);
        });
      }
    }
  }

  Future<void> _pickAudio() async {
  //   if(isRecording) {
  //     String? filePath = await _audioRecorder.stop();
  //     if(filePath != null) {
  //       setState(() {
  //         isRecording = false;
  //         _audioFile = filePath as File?;
  //       });
  //     }
  //   } else {
  //     if(await _audioRecorder.hasPermission()) {
  //       final Directory directory = await getApplicationDocumentsDirectory();
  //       final String filePath = 
  //         '${directory.path}/audio_${_nameController.text}_${DateTime.now().millisecondsSinceEpoch}.aac';
  //       await _audioRecorder.start(
  //         const RecordConfig(),
  //         path: filePath,
  //       );
  //       setState(() {
  //         isRecording = true;
  //       });
  //     }
  //   }
  }

  void _addCategory() {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      setState(() {
        _errorText = 'Category name is required';
      });
      return;
    }

    final newCategory = CategoryModel(
      name: name,
      audioUrl: _audioFile?.path, 
      imageUrl: _imageFile?.path,
      subcategories: [],
    );

    widget.onAddCategory(newCategory);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    //_audioRecorder.closeRecorder(); 
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_imageFile != null)
              Image.file(_imageFile!, height: 100, width: 100, fit: BoxFit.cover),
              ElevatedButton.icon(
                icon: const Icon(Icons.image),
                label: const Text('Add Image'),
                onPressed: _pickImage,
              ),
            const SizedBox(height: 15),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Category Name',
                hintText: 'Enter the category name',
                errorText: _errorText,
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              icon: Icon(isRecording ? Icons.mic :Icons.audiotrack),
              label: const Text('Add Audio'),
              onPressed: _pickAudio,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _addCategory();
                  },
                  child: const Text('Add Category'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}