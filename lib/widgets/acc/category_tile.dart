import 'dart:io';

import 'package:autismcompanionsupport/views/acc/category.dart';
import 'package:autismcompanionsupport/widgets/acc/card_grid_view.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final CategoryModel category;

  const CategoryTile({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardGridView(category: category.name),
          ),
        );
      },
      child: GridTile(
        //footer: Center(child: Text(category.name)),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 3,
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: category.imageUrl != null
                    ? Image.file(
                        File(category.imageUrl!),
                        fit: BoxFit.contain,
                        width: double.infinity,
                      )
                    : Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.image,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text(
                  category.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}//