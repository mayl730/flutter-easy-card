part of 'load_saved_cards_bloc.dart';

sealed class LoadSavedCardsState extends Equatable {
  const LoadSavedCardsState();
  
  @override
  List<Object> get props => [];
}

final class LoadSavedCardsInitial extends LoadSavedCardsState {}

final class LoadSavedCardsPending extends LoadSavedCardsState {}

final class LoadSavedCardsSuccess extends LoadSavedCardsState {
  final List<CardModelWithId> cards;

  const LoadSavedCardsSuccess(this.cards);

  @override
  List<Object> get props => [cards];
}

final class LoadSavedCardsFailure extends LoadSavedCardsState {
  final String error;
  const LoadSavedCardsFailure(this.error);

  @override
  List<Object> get props => [error];
}
