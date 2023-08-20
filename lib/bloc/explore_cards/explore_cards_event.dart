part of 'explore_cards_bloc.dart';

sealed class ExploreCardsEvent extends Equatable {
  const ExploreCardsEvent();

  @override
  List<Object> get props => [];
}

class FetchAllCards extends ExploreCardsEvent {}