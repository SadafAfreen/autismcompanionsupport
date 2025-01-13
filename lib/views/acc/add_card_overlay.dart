import 'dart:io';
import 'package:autismcompanionsupport/utilities/utils.dart';
import 'package:autismcompanionsupport/views/acc/card.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCardOverlay extends StatefulWidget {
  final Function(CardModel) onAddCard;

  const AddCardOverlay({super.key, required this.onAddCard});

  @override
  State<AddCardOverlay> createState() => _AddCardOverlayState();
}

class _AddCardOverlayState extends State<AddCardOverlay> {
  final TextEditingController _nameController = TextEditingController();
  final List<String> _phrases = [];
  String? _errorText;
  File? _imageFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
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

  void _addPhrase(String phrase) {
    setState(() {
      _phrases.add(phrase);
    });
  }

  void _addCard() {
    final name = _nameController.text.trim();
    if (name.isEmpty || _imageFile == null) {
      setState(() {
        _errorText = 'Name and image are required.';
      });
      return;
    }

    final card = CardModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      imageUrl: _imageFile!.path,
      phrases: _phrases,
      audioUrls: [],
    );

    widget.onAddCard(card);
    Navigator.of(context).pop(); // Close the overlay
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
                labelText: 'Card Name',
                hintText: 'Enter the card name',
                errorText: _errorText,
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                final phraseController = TextEditingController();
                await showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Add Phrase'),
                    content: TextField(
                      controller: phraseController,
                      decoration: const InputDecoration(hintText: 'Enter phrase'),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          _addPhrase(phraseController.text.trim());
                          Navigator.pop(context);
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('+ Add Phrase'),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the overlay
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.check, color: Colors.green),
                  onPressed: _addCard, // Save the card and close the overlay
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
