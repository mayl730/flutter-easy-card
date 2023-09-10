part of 'card_details_bloc.dart';

sealed class CardDetailsState extends Equatable {
  const CardDetailsState();

  @override
  List<Object> get props => [];
}

final class CardDetailsInitial extends CardDetailsState {}

final class CardDetailsPending extends CardDetailsState {}

final class CardDetailsSuccess extends CardDetailsState {
  final CardModelWithId cardDetail;
  final bool isSaved;

  const CardDetailsSuccess({required this.cardDetail, required this.isSaved});

  @override
  List<Object> get props => [cardDetail];
}

final class CardDetailsFailure extends CardDetailsState {
  final String error;
  const CardDetailsFailure(this.error);

  @override
  List<Object> get props => [error];
}
