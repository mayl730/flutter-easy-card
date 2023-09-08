import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/core/adapter/user_store.dart';
import 'package:flutter_easy_card/core/types/card_model_with_id.dart';
import 'package:flutter_easy_card/core/types/user.dart';
import 'package:flutter_easy_card/core/utils/firebase_collection_method.dart';

part 'card_details_event.dart';
part 'card_details_state.dart';

class CardDetailsBloc extends Bloc<CardDetailsEvent, CardDetailsState> {
  final UserStore userStore;
  CardDetailsBloc({required this.userStore}) : super(CardDetailsInitial()) {
    on<FetchCardDetails>((event, emit) async {
      emit(CardDetailsPending());
      try {
        String cardId = event.cardId;
        User? user = await userStore.getUser();

        if (user == null) {
          emit(const CardDetailsFailure('No user signed in.'));
          return;
        } else {
        String userId = user.uid!;
        CardModelWithId? cardDetails = await fetchCardByCardId(cardId);
        bool isSaved = await checkIfCardIsSaved(userId: userId, cardId: cardId);
  
        emit(CardDetailsSuccess(cardDetail: cardDetails!, isSaved: isSaved));
        }
        
      } catch (e) {
        emit(CardDetailsFailure(e.toString()));
      }
    });
  }
}
