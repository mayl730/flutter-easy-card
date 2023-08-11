part of 'create_card_bloc.dart';

sealed class CreateCardEvent extends Equatable {
  const CreateCardEvent();

  @override
  List<Object> get props => [];
}

class CreateNewCard extends CreateCardEvent {
  final CardModel cardData;

  const CreateNewCard({
    required this.cardData,
  });
}