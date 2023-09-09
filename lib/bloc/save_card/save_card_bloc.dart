import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/core/adapter/user_store.dart';
import 'package:flutter_easy_card/core/service/firebase_collection_service.dart';
import 'package:flutter_easy_card/core/types/user.dart';

part 'save_card_event.dart';
part 'save_card_state.dart';

class SaveCardBloc extends Bloc<SaveCardEvent, SaveCardState> {
  final UserStore userStore;
  final FirebaseCollectionService firebaseCollectionService;
  SaveCardBloc(
      {required this.userStore, required this.firebaseCollectionService})
      : super(SaveCardInitial()) {
    on<SaveCard>((event, emit) async {
      emit(SaveCardPending());
      try {
        String cardId = event.cardId;
        User? user = await userStore.getUser();
        if (user != null) {
          String userId = user.uid!;
          bool isSaved = await firebaseCollectionService.checkIfCardIsSaved(
              userId: userId, cardId: cardId);
          if (isSaved) {
            await firebaseCollectionService.deleteSavedCardsByUserAndCardId(
                userId: userId, cardId: cardId);
            emit(const SaveCardSuccess(isSaved: false));
          } else {
            await firebaseCollectionService.addSavedCard(
                userId: userId, cardId: cardId);
            emit(const SaveCardSuccess(isSaved: true));
          }
        } else {
          emit(const SaveCardFailure('No user signed in.'));
          return;
        }
      } catch (e) {
        emit(SaveCardFailure(e.toString()));
      }
    });
  }
}
