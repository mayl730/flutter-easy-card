import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easy_card/core/types/card_model_with_id.dart';
import 'package:flutter_easy_card/core/utils/firebase_auth_method.dart';
import 'package:flutter_easy_card/core/utils/firebase_collection_method.dart';

part 'my_cards_event.dart';
part 'my_cards_state.dart';

class MyCardsBloc extends Bloc<MyCardsEvent, MyCardsState> {
  MyCardsBloc() : super(MyCardsInitial()) {
    on<FetchMyCards>((event, emit) async {
      emit(MyCardsPending());
      try {
        User? user = getCurrentUser();
        String userEmail;

        if (user == null) {
          userEmail = "";
        }
        userEmail = user!.email!;
        List<CardModelWithId> cards = await fetchCardsByCreator(userEmail);
        emit(MyCardsSuccess(cards));
      } catch (e) {
        emit(MyCardsFailure(e.toString()));
      }
    });
  }
}
