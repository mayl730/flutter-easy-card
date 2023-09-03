part of 'saved_cards_bloc.dart';

sealed class SavedCardsEvent extends Equatable {
  const SavedCardsEvent();

  @override
  List<Object> get props => [];
}

class FetchSavedCards extends SavedCardsEvent {}