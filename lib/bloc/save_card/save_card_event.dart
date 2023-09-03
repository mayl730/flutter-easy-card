part of 'save_card_bloc.dart';

sealed class SaveCardEvent extends Equatable {
  const SaveCardEvent();

  @override
  List<Object> get props => [];
}

class SaveCard extends SaveCardEvent {
  final String cardId;

  const SaveCard({required this.cardId});

  @override
  List<Object> get props => [cardId];
}