import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/core/service/firebase_collection_service.dart';
import 'package:flutter_easy_card/core/service/firebase_storage_service.dart';
import 'package:flutter_easy_card/core/types/card_model.dart';

part 'edit_card_event.dart';
part 'edit_card_state.dart';

class EditCardBloc extends Bloc<EditCardEvent, EditCardState> {
  FirebaseStorageService firebaseStorageService;
  FirebaseCollectionService firebaseCollectionService;

  EditCardBloc(
      {required this.firebaseStorageService,
      required this.firebaseCollectionService})
      : super(EditCardInitial()) {
    on<EditCard>((event, emit) async {
      emit(EditCardPending());
      try {
        if (event.imageFile != null) {
          String imageUrl = '';

          imageUrl = await firebaseStorageService.uploadFile(
            file: event.imageFile!,
          );
          CardModel updatedCardDataWithNewImage = event.cardData.copyWith(
            imageUrl: imageUrl,
          );

          await firebaseCollectionService.updateCardById(
            card: updatedCardDataWithNewImage,
            cardId: event.cardId,
          );
        } else {
          await firebaseCollectionService.updateCardById(
            card: event.cardData,
            cardId: event.cardId,
          );
        }
        emit(EditCardSuccess());
      } catch (e) {
        emit(EditCardFailure(e.toString()));
      }
    });
  }
}
