import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'saved_cards_event.dart';
part 'saved_cards_state.dart';

class SavedCardsBloc extends Bloc<SavedCardsEvent, SavedCardsState> {
  SavedCardsBloc() : super(SavedCardsInitial()) {
    on<SavedCardsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
