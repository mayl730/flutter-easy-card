part of 'card_details_bloc.dart';

sealed class CardDetailsEvent extends Equatable {
  const CardDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchCardDetails extends CardDetailsEvent {
  final String cardId;

  const FetchCardDetails(this.cardId);

  @override
  List<Object> get props => [cardId];
}

class SaveCard extends CardDetailsEvent {
  final String cardId;

  const SaveCard({required this.cardId});

  @override
  List<Object> get props => [cardId];
}