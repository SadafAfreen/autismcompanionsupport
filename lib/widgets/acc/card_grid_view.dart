import 'dart:io';

import 'package:autismcompanionsupport/services/acc/acc_service.dart';
import 'package:autismcompanionsupport/views/acc/card.dart';
import 'package:autismcompanionsupport/views/acc/card_detailed_view.dart';
import 'package:autismcompanionsupport/views/acc/add_card_overlay.dart';
import 'package:autismcompanionsupport/widgets/acc/add_pack_button.dart';
import 'package:autismcompanionsupport/widgets/acc/card_tile.dart';
import 'package:flutter/material.dart';

class CardGridView extends StatefulWidget {
  final String category;

  const CardGridView({super.key, required this.category});

  @override
  State<CardGridView> createState() => _CardGridViewState();
}

class _CardGridViewState extends State<CardGridView> {
  final ACCService accService = ACCService();
  late Future<List<CardModel>> _cardsFuture;
  late String categoryId;

  @override
  void initState() {
    super.initState();
    _cardsFuture = accService.fetchCategoryCards(categoryId: widget.category);
  }

  void _reloadCards() {
    setState(() {
      _cardsFuture = accService.fetchCategoryCards(categoryId: widget.category);
    });
  }

  void showAddCardOverlay(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return AddCardOverlay(
          onAddCard: (card) async {
            try {
              await accService.addCardToCategory(categoryId: widget.category, card: card,);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Card added successfully!')),
                );
                _reloadCards();
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to add card')),
                );
              }
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: FutureBuilder<List<CardModel>>(
        future: _cardsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } 
          final cards = snapshot.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: cards.length + 1,
            itemBuilder: (context, index) {
              if (index == cards.length) {
                return AddPackButton(onAdd: () => showAddCardOverlay(context));
              }

              // final card = cards[index];
              // return CardTile(card: card);
              
              final card = cards[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CardDetailsView(card: card),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: card.imageUrl != null
                              ? Image.file(
                                  File(card.imageUrl),
                                  fit: BoxFit.contain,
                                  width: double.infinity,)
                              : const Icon(Icons.image, size: 50),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          card.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ); 
        },
      ),
    );
  }
}
