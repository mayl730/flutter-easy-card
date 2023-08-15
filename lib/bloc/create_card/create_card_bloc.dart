import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easy_card/core/types/card_model.dart';

part 'create_card_event.dart';
part 'create_card_state.dart';

class CreateCardBloc extends Bloc<CreateCardEvent, CreateCardState> {
  CreateCardBloc() : super(CreateCardInitial()) {
    on<CreateNewCard>((event, emit) async {
      emit(CreateCardPending());

      try {

        // Upload Image to Firebase Storage
        if (event.imageFile != null) {
          final path = event.imageFile!.path;

          final ref = FirebaseStorage.instance
              .ref()
              .child('card_images')
              .child('${DateTime.now()}.png');
          final uploadTask = ref.putFile(event.imageFile!);
          
          final snapshot = await uploadTask.whenComplete(() => {});

          final imageUrl = await snapshot.ref.getDownloadURL();
          print(imageUrl);
        }

        // Add Card entry
        // CollectionReference cardCollection =
        //     FirebaseFirestore.instance.collection('cards');
        // await cardCollection.add(event.cardData.toMap());

        // print(event.cardData.toString());
        emit(CreateCardSuccess());
      } catch (e) {
        emit(CreateCardFailure(error: e.toString()));
      }
    });
  }
}
