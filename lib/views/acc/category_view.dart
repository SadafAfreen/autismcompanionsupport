import 'package:autismcompanionsupport/services/acc/acc_service.dart';
import 'package:autismcompanionsupport/views/acc/card_detailed_view.dart';
import 'package:autismcompanionsupport/widgets/acc/add_card_button.dart';
import 'package:autismcompanionsupport/widgets/acc/card_tile.dart';
import 'package:flutter/material.dart';
import 'card.dart';

class CategoryView extends StatelessWidget {
  final String categoryName;
  final ACCService firebaseService = ACCService();

  CategoryView({
    super.key, 
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Implement edit functionality for cards
            },
          ),
        ],
      ),
      body: FutureBuilder<List<CardModel>>(
        future: firebaseService.fetchCategoryCards(categoryId: categoryName),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          final cards = snapshot.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: cards.length + 1, // +1 for Add Card option
            itemBuilder: (context, index) {
              if (index == cards.length) {
                return AddCardButton(onAdd: () {
                  // Implement add card functionality
                });
              } else {
                final card = cards[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CardDetailsView(card: card)),
                    );
                  },
                  child: CardTile(card: card),
                );
              }
            },
          );
        },
      ),
    );
  }
}
