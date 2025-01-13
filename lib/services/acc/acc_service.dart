import 'package:autismcompanionsupport/services/acc/acc_exception.dart';
import 'package:autismcompanionsupport/views/acc/card.dart';
import 'package:autismcompanionsupport/views/acc/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ACCService {
  final FirebaseFirestore _categoriesRef = FirebaseFirestore.instance;

  Future<List<CategoryModel>> fetchCategories({required String userId,}) async {
    final snapshot = await _categoriesRef
      .collection("Test_000")
      .doc("profile")
      .collection('category')
      .get();
    return snapshot.docs
      .map((doc) => CategoryModel.fromMap(doc.data()))
      .toList();
  }

  Future<List<CardModel>> fetchCategoryCards({required String categoryId}) async {
    final snapshot = await _categoriesRef
      .collection('Test_000') 
      .doc('profile') 
      .collection('category') 
      .doc(categoryId) 
      .collection('cards')
      .get(); 

    return snapshot.docs.map((doc) {
      return CardModel.fromMap(doc.id, doc.data());
    }).toList();
  }

  Future<void> addCategory({
    required String userId,
    required CategoryModel category,
  }) async {
    if (category.name.isEmpty) {
      throw CategoryNameRequiredException();
    }

    try {
      await _categoriesRef 
          .collection('Test_000')
          .doc('profile')
          .collection('category')
          .add(category.toMap());
    } catch (_) {
      throw CouldNotUploadCategoryException();
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    await _categoriesRef.doc(categoryId).delete();
  }

  Future<void> addCardToCategory({
    required String categoryId, 
    required CardModel card,
  }) async {
    await _categoriesRef
      .collection('Test_000') 
      .doc('profile')
      .collection('category') 
      .doc(categoryId)
      .collection('cards') // Cards sub-collection
      .add(card.toMap());
  }

  Future<void> deleteCard(String categoryId, String cardId) async {
    await _categoriesRef.doc(categoryId).collection('cards').doc(cardId).delete();
  }

  Future<void> updateCard(String categoryId, String cardId, Map<String, dynamic> data) async {
    await _categoriesRef.doc(categoryId).collection('cards').doc(cardId).update(data);
  }
}
