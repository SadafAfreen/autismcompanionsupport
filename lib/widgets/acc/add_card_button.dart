import 'package:flutter/material.dart';

class AddCardButton extends StatelessWidget {
  final VoidCallback onAdd;

  const AddCardButton({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: onAdd,
    );
  }
}