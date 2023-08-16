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

  const CardDetailsSuccess(this.cardDetail);

  @override
  List<Object> get props => [cardDetail];
}

final class CardDetailsFailure extends CardDetailsState {
  final String error;
  const CardDetailsFailure(this.error);

  @override
  List<Object> get props => [error];
}