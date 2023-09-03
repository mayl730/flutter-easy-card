import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easy_card/core/types/card_model_with_id.dart';
import 'package:flutter_easy_card/core/utils/firebase_auth_method.dart';
import 'package:flutter_easy_card/core/utils/firebase_collection_method.dart';

part 'load_saved_cards_event.dart';
part 'load_saved_cards_state.dart';

class LoadSavedCardsBloc extends Bloc<LoadSavedCardsEvent, LoadSavedCardsState> {
  LoadSavedCardsBloc() : super(LoadSavedCardsInitial()) {
    on<LoadSavedCardsEvent>((event, emit) async{
       emit(LoadSavedCardsPending());
      try {
        User? user = getCurrentUser();
        String userId;

        if (user == null) {
          userId = "";
        }
        userId = user!.uid;
        List<CardModelWithId> cards = await fetchCardsFromSavedCards(userId);
        emit(LoadSavedCardsSuccess(cards));
      } catch (e) {
        emit(LoadSavedCardsFailure(e.toString()));
      }
    });
  }
}
