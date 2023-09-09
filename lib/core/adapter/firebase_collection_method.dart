import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easy_card/core/types/card_model.dart';

abstract class FirebaseCollectionMethod {
  Future addCard({required CardModel card});
  factory FirebaseCollectionMethod() => _FirebaseCollectionMethod();
}

class _FirebaseCollectionMethod implements FirebaseCollectionMethod {
  final CollectionReference _cardCollection =
      FirebaseFirestore.instance.collection('cards');
  @override
  Future addCard({required CardModel card}) async {
    try {
      await _cardCollection.add(card.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
