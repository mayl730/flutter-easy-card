import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easy_card/core/types/card_model_with_id.dart';

part 'card_details_event.dart';
part 'card_details_state.dart';

class CardDetailsBloc extends Bloc<CardDetailsEvent, CardDetailsState> {
  CardDetailsBloc() : super(CardDetailsInitial()) {
    on<FetchCardDetails>((event, emit) {
      emit(CardDetailsPending());
  
    });
  }
}
