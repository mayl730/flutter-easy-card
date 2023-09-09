import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easy_card/core/adapter/firebase_storage_method.dart';
import 'package:flutter_easy_card/core/adapter/user_store.dart';
import 'package:flutter_easy_card/core/types/card_model.dart';
import 'package:flutter_easy_card/core/types/user.dart';

part 'create_card_event.dart';
part 'create_card_state.dart';

class CreateCardBloc extends Bloc<CreateCardEvent, CreateCardState> {
  UserStore userStore;
  FirebaseStorageMethod firebaseStorageMethod = FirebaseStorageMethod();
  CreateCardBloc({required this.userStore}) : super(CreateCardInitial()) {
    on<CreateNewCard>((event, emit) async {
      emit(CreateCardPending());

      try {
        String imageUrl = '';

        if (event.imageFile != null) {
          imageUrl = await firebaseStorageMethod.uploadFile(
            file: event.imageFile!,
          );
        }

        User? user = await userStore.getUser();
        String? creatorEmail = user?.email;

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
