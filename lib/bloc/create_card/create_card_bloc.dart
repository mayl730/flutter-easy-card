import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easy_card/core/types/card_model.dart';

part 'create_card_event.dart';
part 'create_card_state.dart';

class CreateCardBloc extends Bloc<CreateCardEvent, CreateCardState> {
  CreateCardBloc() : super(CreateCardInitial()) {
    on<CreateNewCard>((event, emit) async {
      print('CreateNewCard');
      emit(CreateCardPending());
      CollectionReference cardCollection =
          FirebaseFirestore.instance.collection('cards');
      try {
        await cardCollection.add(event.cardData.toMap());
        print(event.cardData.toString());
        emit(CreateCardSuccess());
      } catch (e) {
        emit(CreateCardFailure(error: e.toString()));
      }
    });
  }
}
