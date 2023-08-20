import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easy_card/core/types/card_model_with_id.dart';

part 'explore_cards_event.dart';
part 'explore_cards_state.dart';

class ExploreCardsBloc extends Bloc<ExploreCardsEvent, ExploreCardsState> {
  ExploreCardsBloc() : super(ExploreCardsInitial()) {
    on<FetchAllCards>((event, emit) {
      emit(ExploreCardsPending());
      try {
        List<CardModelWithId> cards = [];
        emit(ExploreCardsSuccess(cards));
      } catch (e) {
        emit(ExploreCardsFailure(e.toString()));
      }
    });
  }
}
