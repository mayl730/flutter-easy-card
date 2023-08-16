import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> fetchCardsByCreator(String creatorEmail) async {
  CollectionReference cardCollection = FirebaseFirestore.instance.collection('cards');
  
  try {
    QuerySnapshot querySnapshot = await cardCollection.where('creator', isEqualTo: creatorEmail).get();
    
    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      String docId = docSnapshot.id;
      String cardName = docSnapshot.get('name');
      String cardCompany = docSnapshot.get('company');
    }
  } catch (e) {
    print('Error fetching cards: $e');
  }
}

