import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/core/adapter/user_store.dart';
import 'package:flutter_easy_card/core/types/card_model_with_id.dart';
import 'package:flutter_easy_card/core/types/user.dart';

import 'package:flutter_easy_card/core/utils/firebase_collection_method.dart';

part 'my_cards_event.dart';
part 'my_cards_state.dart';

class MyCardsBloc extends Bloc<MyCardsEvent, MyCardsState> {
  final UserStore userStore;
  MyCardsBloc({required this.userStore}) : super(MyCardsInitial()) {
    on<FetchMyCards>((event, emit) async {
      emit(MyCardsPending());
      try {
        User? user = await userStore.getUser();
        String userEmail;
        userEmail = user?.email ?? "";
        List<CardModelWithId> cards = await fetchCardsByCreator(userEmail);
        emit(MyCardsSuccess(cards));
      } catch (e) {
        emit(MyCardsFailure(e.toString()));
      }
    });
  }
}
