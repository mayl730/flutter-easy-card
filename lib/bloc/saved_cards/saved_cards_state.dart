part of 'saved_cards_bloc.dart';

sealed class SavedCardsState extends Equatable {
  const SavedCardsState();
  
  @override
  List<Object> get props => [];
}

final class SavedCardsInitial extends SavedCardsState {}
