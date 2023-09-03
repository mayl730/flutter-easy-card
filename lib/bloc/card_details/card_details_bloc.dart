import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easy_card/core/types/card_model_with_id.dart';
import 'package:flutter_easy_card/core/utils/firebase_auth_method.dart';
import 'package:flutter_easy_card/core/utils/firebase_collection_method.dart';

part 'card_details_event.dart';
part 'card_details_state.dart';

class CardDetailsBloc extends Bloc<CardDetailsEvent, CardDetailsState> {
  CardDetailsBloc() : super(CardDetailsInitial()) {
    on<FetchCardDetails>((event, emit) async {
      emit(CardDetailsPending());
      try {
        String cardId = event.cardId;
        User? user = getCurrentUser();
        String userId = user!.uid;
        CardModelWithId? cardDetails = await fetchCardByCardId(cardId);
        bool isSaved = await checkIfCardIsSaved(userId: userId, cardId: cardId);
  
        emit(CardDetailsSuccess(cardDetail: cardDetails!, isSaved: isSaved));
      } catch (e) {
        emit(CardDetailsFailure(e.toString()));
      }
    });
  }
}
