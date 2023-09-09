import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_card/core/types/card_model_with_id.dart';



Future<List<CardModelWithId>> fetchCardsByCreator(String creatorEmail) async {
  CollectionReference cardCollection =
      FirebaseFirestore.instance.collection('cards');

  List<CardModelWithId> cardsList = [];

  try {
    if (creatorEmail == "") {
      return cardsList;
    }
    QuerySnapshot querySnapshot = await cardCollection
        .where('creator', isEqualTo: creatorEmail)
        .orderBy('updatedAt', descending: true)
        .get();

    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      CardModelWithId card = CardModelWithId(
        id: docSnapshot.id,
        colorTheme: docSnapshot.get('colorTheme'),
        company: docSnapshot.get('company'),
        creator: creatorEmail,
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

      cardsList.add(card);
    }
    return cardsList;
  } catch (e) {
    debugPrint('Error fetching cards: $e');
    return [];
  }
}

Future<CardModelWithId?> fetchCardByCardId(String cardId) async {
  try {
    CollectionReference cardCollection =
        FirebaseFirestore.instance.collection('cards');

    DocumentSnapshot docSnapshot = await cardCollection.doc(cardId).get();

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

Future<List<CardModelWithId>> fetchAllNonPrivateCards() async {
  CollectionReference cardCollection =
      FirebaseFirestore.instance.collection('cards');

  List<CardModelWithId> cardsList = [];

  try {
    QuerySnapshot querySnapshot = await cardCollection
        .where('isPrivate', isEqualTo: false)
        .orderBy('updatedAt', descending: true)
        .get();

    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
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

      cardsList.add(card);
    }
    return cardsList;
  } catch (e) {
    debugPrint('Error fetching cards: $e');
    return [];
  }
}

// Collection: savedCards functions

Future<List<CardModelWithId>> fetchCardsFromSavedCards(String userId) async {
  List<CardModelWithId> cardsList = [];
  try {
    List<String> savedCardIds = await fetchSavedCardIdsByUserId(userId);

    for (String cardId in savedCardIds) {
      CardModelWithId? card = await fetchCardByCardId(cardId);
      if (card != null) {
        cardsList.add(card);
      }
    }
    debugPrint(cardsList.toString());
    return cardsList;
  } catch (e) {
    debugPrint('Error fetchCardsFromSavedCards: $e');
    return [];
  }
}

Future<bool> checkIfCardIsSaved(
    {required String userId, required String cardId}) async {
  try {
    CollectionReference savedCardsCollection =
        FirebaseFirestore.instance.collection('savedCards');

    final QuerySnapshot querySnapshot = await savedCardsCollection
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

Future<void> addSaveCard(
    {required String userId, required String cardId}) async {
  try {
    CollectionReference savedCardsCollection =
        FirebaseFirestore.instance.collection('savedCards');

    final Timestamp timestamp = Timestamp.now();

    await savedCardsCollection.add({
      'userId': userId,
      'cardId': cardId,
      'savedAt': timestamp,
    });
  } catch (e) {
    debugPrint('Error saving card: $e');
  }
}

Future<void> removeSavedCard(
    {required String userId, required String cardId}) async {
  try {
    CollectionReference savedCardsCollection =
        FirebaseFirestore.instance.collection('savedCards');

    final QuerySnapshot querySnapshot = await savedCardsCollection
        .where('userId', isEqualTo: userId)
        .where('cardId', isEqualTo: cardId)
        .get();

    final String savedCardId = querySnapshot.docs.first.id;

    await savedCardsCollection.doc(savedCardId).delete();
  } catch (e) {
    debugPrint('Error deleteSavedCard: $e');
  }
}

Future<void> deleteCardById(String cardId) async {
  try {
    CollectionReference cardCollection =
        FirebaseFirestore.instance.collection('cards');
    await cardCollection.doc(cardId).delete();
    debugPrint('Card with ID $cardId deleted successfully');
  } catch (e) {
    debugPrint('Error deleteCardById: $e');
  }
}

Future<List<String>> fetchSavedCardIdsByUserId(String userId) async {
  try {
    CollectionReference savedCardsCollection =
        FirebaseFirestore.instance.collection('savedCards');

    final QuerySnapshot querySnapshot =
        await savedCardsCollection.where('userId', isEqualTo: userId).orderBy('savedAt', descending: true).get();

    final List<String> savedCardIds =
        querySnapshot.docs.map((doc) => doc.get('cardId') as String).toList();

    return savedCardIds;
  } catch (e) {
    debugPrint('Error fetchSavedCardIdsByUserId: $e');
    return [];
  }
}

Future<void> deleteSavedCardsByCardId(String cardId) async {
  try {
    CollectionReference savedCardsCollection =
        FirebaseFirestore.instance.collection('savedCards');

    final query = savedCardsCollection.where('cardId', isEqualTo: cardId);
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
