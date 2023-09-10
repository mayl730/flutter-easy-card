part of 'load_saved_cards_bloc.dart';

sealed class LoadSavedCardsEvent extends Equatable {
  const LoadSavedCardsEvent();

  @override
  List<Object> get props => [];
}

class FetchSavedCards extends LoadSavedCardsEvent {}
