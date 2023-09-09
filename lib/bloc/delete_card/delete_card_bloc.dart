import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/core/service/firebase_collection_service.dart';

part 'delete_card_event.dart';
part 'delete_card_state.dart';

class DeleteCardBloc extends Bloc<DeleteCardEvent, DeleteCardState> {
  final FirebaseCollectionService firebaseCollectionService;

  DeleteCardBloc({required this.firebaseCollectionService})
      : super(DeleteCardInitial()) {
    on<DeleteCardRequest>((event, emit) async {
      emit(DeleteCardPending());
      try {
        await firebaseCollectionService.deleteCardById(cardId: event.cardId);
        await firebaseCollectionService.deleteSavedCardsByCardId(
            cardId: event.cardId);
        emit(DeleteCardSuccess());
      } catch (e) {
        emit(DeleteCardFailure(e.toString()));
      }
    });
  }
}
