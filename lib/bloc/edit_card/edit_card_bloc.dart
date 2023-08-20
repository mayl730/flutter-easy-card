import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easy_card/core/types/card_model.dart';

part 'edit_card_event.dart';
part 'edit_card_state.dart';

class EditCardBloc extends Bloc<EditCardEvent, EditCardState> {
  EditCardBloc() : super(EditCardInitial()) {
    on<EditCard>((event, emit) async {
      emit(EditCardPending());

      try {
        CollectionReference cardCollection =
            FirebaseFirestore.instance.collection('cards');

        if (event.imageFile != null) {
          String imageUrl = '';
          Reference ref = FirebaseStorage.instance
              .ref()
              .child('card_images')
              .child('${DateTime.now()}.png');
          UploadTask uploadTask = ref.putFile(event.imageFile!);
          TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
          imageUrl = await snapshot.ref.getDownloadURL();
          CardModel updatedCardDataWithNewImage = event.cardData.copyWith(
            imageUrl: imageUrl,
          );
          await cardCollection
              .doc(event.cardId)
              .update(updatedCardDataWithNewImage.toMap());
        } else {
          await cardCollection.doc(event.cardId).update(event.cardData.toMap());
        }
        print('edit card success!');
        emit(EditCardSuccess());
      } catch (e) {
        emit(EditCardFailure(e.toString()));
      }
    });
  }
}
