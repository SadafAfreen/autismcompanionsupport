import 'package:flutter/material.dart';
import 'card.dart';
import 'add_phrase_overlay.dart';

class CardDetailsView extends StatelessWidget {
  final CardModel card;

  const CardDetailsView({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(card.name)),
      body: Column(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(card.imageUrl), radius: 50),
          Text(card.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: card.phrases?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(card.phrases![index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () {
                      // Play audio if available
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            child: const Text("+ Add New Phrase"),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => AddPhraseOverlay(card: card),
              );
            },
          ),
        ],
      ),
    );
  }
}
