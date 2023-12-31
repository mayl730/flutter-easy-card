import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/core/service/firebase_collection_service.dart';
import 'package:flutter_easy_card/core/service/firebase_storage_service.dart';
import 'package:flutter_easy_card/core/adapter/user_store.dart';
import 'package:flutter_easy_card/core/types/card_model.dart';
import 'package:flutter_easy_card/core/types/user.dart';

part 'create_card_event.dart';
part 'create_card_state.dart';

class CreateCardBloc extends Bloc<CreateCardEvent, CreateCardState> {
  final UserStore userStore;
  final FirebaseStorageService firebaseStorageService;
  final FirebaseCollectionService firebaseCollectionService;
  CreateCardBloc(
      {required this.userStore,
      required this.firebaseStorageService,
      required this.firebaseCollectionService})
      : super(CreateCardInitial()) {
    on<CreateNewCard>((event, emit) async {
      emit(CreateCardPending());

      try {
        String imageUrl = '';

        if (event.imageFile != null) {
          imageUrl = await firebaseStorageService.uploadFile(
            file: event.imageFile!,
          );
        }

        User? user = await userStore.getUser();
        String? creatorEmail = user?.email;

        CardModel updatedCardData = event.cardData.copyWith(
          imageUrl: imageUrl,
          creator: creatorEmail ?? 'no_creator',
        );

        await firebaseCollectionService.addCard(card: updatedCardData);

        emit(CreateCardSuccess());
      } catch (e) {
        emit(CreateCardFailure(error: e.toString()));
      }
    });
  }
}
