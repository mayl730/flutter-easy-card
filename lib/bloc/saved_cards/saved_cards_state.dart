part of 'saved_cards_bloc.dart';

sealed class SavedCardsState extends Equatable {
  const SavedCardsState();
  
  @override
  List<Object> get props => [];
}

final class SavedCardsInitial extends SavedCardsState {}

final class SavedCardsPending extends SavedCardsState {}

final class SavedCardsSuccess extends SavedCardsState {
  final List<CardModelWithId> cards;

  const SavedCardsSuccess(this.cards);

  @override
  List<Object> get props => [cards];
}

final class SavedCardsFailure extends SavedCardsState {
  final String error;
  const SavedCardsFailure(this.error);

  @override
  List<Object> get props => [error];
}
