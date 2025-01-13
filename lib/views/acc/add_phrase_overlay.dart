import 'package:flutter/material.dart';
import 'card.dart';

class AddPhraseOverlay extends StatelessWidget {
  final CardModel card;

  const AddPhraseOverlay({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text("Add New Phrase", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: () {
              // Add image functionality
            },
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Card Name"),
            controller: TextEditingController(text: card.name),
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            itemCount: card.phrases?.length ?? 0,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(card.phrases![index]),
                trailing: IconButton(
                  icon: const Icon(Icons.mic),
                  onPressed: () {
                    // Add audio functionality
                  },
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add new phrase to list
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
