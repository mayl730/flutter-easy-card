part of 'create_card_bloc.dart';

sealed class CreateCardState extends Equatable {
  const CreateCardState();

  @override
  List<Object> get props => [];
}

final class CreateCardInitial extends CreateCardState {}

final class CreateCardPending extends CreateCardState {}

final class CreateCardSuccess extends CreateCardState {}

final class CreateCardFailure extends CreateCardState {
  final String error;

  const CreateCardFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
