import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easy_card/core/types/card_model_with_id.dart';
import 'package:flutter_easy_card/core/utils/firebase_auth_method.dart';
import 'package:flutter_easy_card/core/utils/firebase_collection_method.dart';

part 'saved_cards_event.dart';
part 'saved_cards_state.dart';

class SavedCardsBloc extends Bloc<SavedCardsEvent, SavedCardsState> {
  SavedCardsBloc() : super(SavedCardsInitial()) {
    on<SavedCardsEvent>((event, emit) async{
       emit(SavedCardsPending());
      try {
        User? user = getCurrentUser();
        String userId;

        if (user == null) {
          userId = "";
        }
        userId = user!.uid;
        List<CardModelWithId> cards = await fetchCardsFromSavedCards(userId);
        emit(SavedCardsSuccess(cards));
      } catch (e) {
        emit(SavedCardsFailure(e.toString()));
      }
    });
  }
}
