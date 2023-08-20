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
        // .orderBy('createdAt', descending: true)
        .get();

        //TODO: Add orderBy('createdAt', descending: true) back in when it's working

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
      );

      cardsList.add(card);
    }
    return cardsList;
  } catch (e) {
    debugPrint('Error fetching cards: $e');
    return [];
  }
}

Future<CardModelWithId?> fetchCardById(String cardId) async {
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
    );

    return card;
  } catch (e) {
    print('Error fetching card: $e');
    return null;
  }
}

Future<List<CardModelWithId>> fetchAllNonPrivateCards() async {
  CollectionReference cardCollection =
      FirebaseFirestore.instance.collection('cards');

  List<CardModelWithId> cardsList = [];

  try {
    QuerySnapshot querySnapshot =
        await cardCollection.where('isPrivate', isEqualTo: false).get();

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
      );

      cardsList.add(card);
    }
    return cardsList;
  } catch (e) {
    debugPrint('Error fetching cards: $e');
    return [];
  }
}

Future<void> deleteCardById(String cardId) async {
  try {
    CollectionReference cardCollection =
        FirebaseFirestore.instance.collection('cards');
    await cardCollection.doc(cardId).delete();
    debugPrint('Card with ID $cardId deleted successfully');
  } catch (e) {
    debugPrint('Error deleting card: $e');
  }
}
