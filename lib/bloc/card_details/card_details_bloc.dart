import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/core/adapter/user_store.dart';
import 'package:flutter_easy_card/core/service/firebase_collection_service.dart';
import 'package:flutter_easy_card/core/types/card_model_with_id.dart';
import 'package:flutter_easy_card/core/types/user.dart';

part 'card_details_event.dart';
part 'card_details_state.dart';

class CardDetailsBloc extends Bloc<CardDetailsEvent, CardDetailsState> {
  final UserStore userStore;
  final FirebaseCollectionService firebaseCollectionService;
  CardDetailsBloc(
      {required this.userStore, required this.firebaseCollectionService})
      : super(CardDetailsInitial()) {
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
          CardModelWithId? cardDetails =
              await firebaseCollectionService.fetchCardByCardId(cardId: cardId);
          bool isSaved = await firebaseCollectionService.checkIfCardIsSaved(
              userId: userId, cardId: cardId);

          emit(CardDetailsSuccess(cardDetail: cardDetails!, isSaved: isSaved));
        }
      } catch (e) {
        emit(CardDetailsFailure(e.toString()));
      }
    });
  }
}
