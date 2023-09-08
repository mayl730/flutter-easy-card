import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/core/adapter/user_store.dart';
import 'package:flutter_easy_card/core/types/user.dart';
import 'package:flutter_easy_card/core/utils/firebase_collection_method.dart';

part 'save_card_event.dart';
part 'save_card_state.dart';

class SaveCardBloc extends Bloc<SaveCardEvent, SaveCardState> {
  final UserStore userStore;
  SaveCardBloc({required this.userStore}) : super(SaveCardInitial()) {
    on<SaveCard>((event, emit) async {
      emit(SaveCardPending());
      try {
        String cardId = event.cardId;
        // User? user = getCurrentUser();
        User? user = await userStore.getUser();
        if (user != null) {
          String userId = user.uid!;
          bool isSaved =
              await checkIfCardIsSaved(userId: userId, cardId: cardId);
          if (isSaved) {
            await removeSavedCard(userId: userId, cardId: cardId);
            emit(const SaveCardSuccess(isSaved: false));
          } else {
            await addSaveCard(userId: userId, cardId: cardId);
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
