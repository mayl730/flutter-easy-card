part of 'save_card_bloc.dart';

sealed class SaveCardState extends Equatable {
  const SaveCardState();

  @override
  List<Object> get props => [];
}

final class SaveCardInitial extends SaveCardState {}

final class SaveCardPending extends SaveCardState {}

final class SaveCardSuccess extends SaveCardState {
  final bool isSaved;
  const SaveCardSuccess({required this.isSaved});
}

final class SaveCardFailure extends SaveCardState {
  final String error;
  const SaveCardFailure(this.error);

  @override
  List<Object> get props => [error];
}
