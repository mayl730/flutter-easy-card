import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/core/adapter/user_store.dart';
import 'package:flutter_easy_card/core/service/firebase_collection_service.dart';
import 'package:flutter_easy_card/core/types/card_model_with_id.dart';
import 'package:flutter_easy_card/core/types/user.dart';

part 'my_cards_event.dart';
part 'my_cards_state.dart';

class MyCardsBloc extends Bloc<MyCardsEvent, MyCardsState> {
  final UserStore userStore;
  final FirebaseCollectionService firebaseCollectionService;
  MyCardsBloc(
      {required this.userStore, required this.firebaseCollectionService})
      : super(MyCardsInitial()) {
    on<FetchMyCards>((event, emit) async {
      emit(MyCardsPending());
      try {
        User? user;
        while (user == null) {
          user = await userStore.getUser();
          await Future.delayed(const Duration(milliseconds: 100));
        }
        String userEmail = user.email ?? "";
        List<CardModelWithId> cards = await firebaseCollectionService
            .fetchCardsByCreatorEmail(creatorEmail: userEmail);
        emit(MyCardsSuccess(cards));
      } catch (e) {
        emit(MyCardsFailure(e.toString()));
      }
    });
  }
}
