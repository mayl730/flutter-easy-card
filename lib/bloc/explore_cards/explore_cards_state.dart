part of 'explore_cards_bloc.dart';

sealed class ExploreCardsState extends Equatable {
  const ExploreCardsState();

  @override
  List<Object> get props => [];
}

final class ExploreCardsInitial extends ExploreCardsState {}

final class ExploreCardsPending extends ExploreCardsState {}

final class ExploreCardsSuccess extends ExploreCardsState {
  final List<CardModelWithId> cards;

  const ExploreCardsSuccess(this.cards);

  @override
  List<Object> get props => [cards];
}

final class ExploreCardsFailure extends ExploreCardsState {
  final String error;
  const ExploreCardsFailure(this.error);

  @override
  List<Object> get props => [error];
}
