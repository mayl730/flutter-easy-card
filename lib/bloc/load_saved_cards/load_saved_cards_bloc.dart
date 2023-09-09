import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/core/adapter/user_store.dart';
import 'package:flutter_easy_card/core/service/firebase_collection_service.dart';
import 'package:flutter_easy_card/core/types/card_model_with_id.dart';
import 'package:flutter_easy_card/core/types/user.dart';

part 'load_saved_cards_event.dart';
part 'load_saved_cards_state.dart';

class LoadSavedCardsBloc
    extends Bloc<LoadSavedCardsEvent, LoadSavedCardsState> {
  final UserStore userStore;
  final FirebaseCollectionService firebaseCollectionService;
  LoadSavedCardsBloc(
      {required this.userStore, required this.firebaseCollectionService})
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
        List<CardModelWithId> cards = await firebaseCollectionService
            .fetchCardsFromSavedCardsByUserId(userId: userId);
        emit(LoadSavedCardsSuccess(cards));
      } catch (e) {
        emit(LoadSavedCardsFailure(e.toString()));
      }
    });
  }
}
