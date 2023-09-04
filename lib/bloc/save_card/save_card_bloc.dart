import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easy_card/core/utils/firebase_auth_method.dart';
import 'package:flutter_easy_card/core/utils/firebase_collection_method.dart';

part 'save_card_event.dart';
part 'save_card_state.dart';

class SaveCardBloc extends Bloc<SaveCardEvent, SaveCardState> {
  SaveCardBloc() : super(SaveCardInitial()) {
    on<SaveCard>((event, emit) async {
      emit(SaveCardPending());
      try {
        String cardId = event.cardId;
        User? user = getCurrentUser();
        String userId = user!.uid;

        bool isSaved = await checkIfCardIsSaved(userId: userId, cardId: cardId);
        if (isSaved) {
          await removeSavedCard(userId: userId, cardId: cardId);
          print('removeSavedCard');
          emit(const SaveCardSuccess(isSaved: false));
        } else {
          await addSaveCard(userId: userId, cardId: cardId);
          print('addSavedCard');
          emit(const SaveCardSuccess(isSaved: true));
        }
      } catch (e) {
        emit(SaveCardFailure(e.toString()));
      }
    });
  }
}