import 'package:flutter/material.dart';

class AddPackButton extends StatelessWidget {
  final VoidCallback onAdd;

  const AddPackButton({
    super.key, 
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAdd,
      child: Card(
        color: Colors.grey[200],
        child: const Center(
          child: Text('+ Add Pack'),
        ),
      ),
    );
  }
}