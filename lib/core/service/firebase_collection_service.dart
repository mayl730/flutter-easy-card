import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_card/core/types/card_model.dart';
import 'package:flutter_easy_card/core/types/card_model_with_id.dart';

abstract class FirebaseCollectionService {
  Future<void> addCard({required CardModel card});
  Future<CardModelWithId?> fetchCardByCardId({required String cardId});
  Future<bool> checkIfCardIsSaved(
      {required String userId, required String cardId});

  Future<void> deleteCardById({required String cardId});
  Future<void> deleteSavedCardsByCardId({required String cardId});

  factory FirebaseCollectionService() => _FirebaseCollectionService();
}

class _FirebaseCollectionService implements FirebaseCollectionService {
  final CollectionReference _cardCollection =
      FirebaseFirestore.instance.collection('cards');
  final CollectionReference _savedCardsCollection =
      FirebaseFirestore.instance.collection('savedCards');
  @override
  Future<void> addCard({required CardModel card}) async {
    try {
      await _cardCollection.add(card.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CardModelWithId?> fetchCardByCardId({required String cardId}) async {
    try {
      DocumentSnapshot docSnapshot = await _cardCollection.doc(cardId).get();

      CardModelWithId card = CardModelWithId(
        id: docSnapshot.id,
        colorTheme: docSnapshot.get('colorTheme'),
        company: docSnapshot.get('company'),
        creator: docSnapshot.get('creator'),
        email: docSnapshot.get('email'),
        facebook: docSnapshot.get('facebook'),
        imageUrl: docSnapshot.get('imageUrl'),
        isPrivate: docSnapshot.get('isPrivate'),
        jobTitle: docSnapshot.get('jobTitle'),
        linkedin: docSnapshot.get('linkedin'),
        name: docSnapshot.get('name'),
        phone: docSnapshot.get('phone'),
        twitter: docSnapshot.get('twitter'),
        website: docSnapshot.get('website'),
        createdAt: docSnapshot.get('createdAt'),
        updatedAt: docSnapshot.get('updatedAt'),
      );

      return card;
    } catch (e) {
      debugPrint('Error fetching card: $e');
      return null;
    }
  }

  @override
  Future<bool> checkIfCardIsSaved(
      {required String userId, required String cardId}) async {
    try {
      final QuerySnapshot querySnapshot = await _savedCardsCollection
          .where('userId', isEqualTo: userId)
          .where('cardId', isEqualTo: cardId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Error checkIfCardIsSaved: $e');
      return false;
    }
  }

  @override
  Future<void> deleteCardById({required String cardId}) async {
    try {
      await _cardCollection.doc(cardId).delete();
      debugPrint('Card with ID $cardId deleted successfully');
    } catch (e) {
      debugPrint('Error deleteCardById: $e');
    }
  }

  @override
  Future<void> deleteSavedCardsByCardId({required String cardId}) async {
    try {
      final query = _savedCardsCollection.where('cardId', isEqualTo: cardId);
      final querySnapshot = await query.get();

      for (final doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      debugPrint(
          'deleteSavedCardsByCardId: Cards with ID $cardId deleted successfully');
    } catch (e) {
      debugPrint('deleteSavedCardsByCardId: Error deleteCardById: $e');
    }
  }
}