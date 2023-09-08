import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/core/adapter/user_store.dart';
import 'package:flutter_easy_card/core/types/card_model_with_id.dart';
import 'package:flutter_easy_card/core/types/user.dart';
import 'package:flutter_easy_card/core/utils/firebase_collection_method.dart';

part 'load_saved_cards_event.dart';
part 'load_saved_cards_state.dart';

class LoadSavedCardsBloc
    extends Bloc<LoadSavedCardsEvent, LoadSavedCardsState> {
  final UserStore userStore;
  LoadSavedCardsBloc({required this.userStore})
      : super(LoadSavedCardsInitial()) {
    on<LoadSavedCardsEvent>((event, emit) async {
      emit(LoadSavedCardsPending());
      try {
        User? user = await userStore.getUser();
        String userId;

        if (user == null) {
          userId = "";
        } else {
          userId = user.uid!;
        }
        List<CardModelWithId> cards = await fetchCardsFromSavedCards(userId);
        emit(LoadSavedCardsSuccess(cards));
      } catch (e) {
        emit(LoadSavedCardsFailure(e.toString()));
      }
    });
  }
}
