part of 'my_cards_bloc.dart';

sealed class MyCardsState extends Equatable {
  const MyCardsState();
  
  @override
  List<Object> get props => [];
}

final class MyCardsInitial extends MyCardsState {}

final class MyCardsPending extends MyCardsState {}

final class MyCardsSuccess extends MyCardsState {
  final List<CardModelWithId> cards;

  const MyCardsSuccess(this.cards);

  @override
  List<Object> get props => [cards];
}

final class MyCardsFailure extends MyCardsState {
  final String error;
  const MyCardsFailure(this.error);

  @override
  List<Object> get props => [error];
}