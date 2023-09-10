part of 'my_cards_bloc.dart';

sealed class MyCardsEvent extends Equatable {
  const MyCardsEvent();

  @override
  List<Object> get props => [];
}

class FetchMyCards extends MyCardsEvent {}
