import 'package:autismcompanionsupport/views/acc/card.dart';
import 'package:flutter/material.dart';

class CardTile extends StatelessWidget {
  final CardModel card;

  const CardTile({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: Center(child: Text(card.name)),
      child: CircleAvatar(backgroundImage: NetworkImage(card.imageUrl)),
    );
  }
}