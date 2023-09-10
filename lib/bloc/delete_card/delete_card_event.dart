part of 'delete_card_bloc.dart';

sealed class DeleteCardEvent extends Equatable {
  const DeleteCardEvent();

  @override
  List<Object> get props => [];
}

final class DeleteCardRequest extends DeleteCardEvent {
  final String cardId;

  const DeleteCardRequest(this.cardId);

  @override
  List<Object> get props => [cardId];
}
