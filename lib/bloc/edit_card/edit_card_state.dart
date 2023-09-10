part of 'edit_card_bloc.dart';

sealed class EditCardState extends Equatable {
  const EditCardState();

  @override
  List<Object> get props => [];
}

final class EditCardInitial extends EditCardState {}

final class EditCardPending extends EditCardState {}

final class EditCardSuccess extends EditCardState {}

final class EditCardFailure extends EditCardState {
  final String error;
  const EditCardFailure(this.error);

  @override
  List<Object> get props => [error];
}
