import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easy_card/core/utils/firebase_collection_method.dart';

part 'delete_card_event.dart';
part 'delete_card_state.dart';

class DeleteCardBloc extends Bloc<DeleteCardEvent, DeleteCardState> {
  DeleteCardBloc() : super(DeleteCardInitial()) {
    on<DeleteCardRequest>((event, emit) async{
      emit(DeleteCardPending());
      try {
        await deleteCardById(event.cardId);
        emit(DeleteCardSuccess());
      } catch (e) {
        emit(DeleteCardFailure(e.toString()));
      }
    });
  }
}
