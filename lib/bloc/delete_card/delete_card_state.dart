part of 'delete_card_bloc.dart';

sealed class DeleteCardState extends Equatable {
  const DeleteCardState();
  
  @override
  List<Object> get props => [];
}

final class DeleteCardInitial extends DeleteCardState {}

final class DeleteCardPending extends DeleteCardState {}

final class DeleteCardSuccess extends DeleteCardState {}

final class DeleteCardFailure extends DeleteCardState {
  final String error;

  const DeleteCardFailure(this.error);

  @override
  List<Object> get props => [error];
}