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
    QuerySnapshot querySnapshot =
        await cardCollection.where('creator', isEqualTo: creatorEmail).get();

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

    print(cardsList);
  } catch (e) {
    debugPrint('Error fetching cards: $e');
  }

  return cardsList;
}
