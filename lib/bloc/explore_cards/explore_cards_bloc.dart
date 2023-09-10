import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/core/service/firebase_collection_service.dart';
import 'package:flutter_easy_card/core/types/card_model_with_id.dart';

part 'explore_cards_event.dart';
part 'explore_cards_state.dart';

class ExploreCardsBloc extends Bloc<ExploreCardsEvent, ExploreCardsState> {
  final FirebaseCollectionService firebaseCollectionService;
  ExploreCardsBloc({required this.firebaseCollectionService})
      : super(ExploreCardsInitial()) {
    on<FetchAllCards>((event, emit) async {
      emit(ExploreCardsPending());
      try {
        List<CardModelWithId> cards =
            await firebaseCollectionService.fetchAllNonPrivateCards();
        emit(ExploreCardsSuccess(cards));
      } catch (e) {
        emit(ExploreCardsFailure(e.toString()));
      }
    });
  }
}
