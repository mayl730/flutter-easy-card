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
        String imageUrl = '';

        if (event.imageFile != null) {
          Reference ref = FirebaseStorage.instance
              .ref()
              .child('card_images')
              .child('${DateTime.now()}.png');
          UploadTask uploadTask = ref.putFile(event.imageFile!);
          TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
          imageUrl = await snapshot.ref.getDownloadURL();
        }

        String? creatorEmail = FirebaseAuth.instance.currentUser?.email;

        CardModel updatedCardData = event.cardData.copyWith(
          imageUrl: imageUrl,
          creator: creatorEmail ?? 'no_creator',
        );

        CollectionReference cardCollection =
            FirebaseFirestore.instance.collection('cards');
        await cardCollection.add(updatedCardData.toMap());

        emit(CreateCardSuccess());
      } catch (e) {
        emit(CreateCardFailure(error: e.toString()));
      }
    });
  }
}
