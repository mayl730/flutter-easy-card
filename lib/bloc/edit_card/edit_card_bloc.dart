import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easy_card/core/types/card_model.dart';

part 'edit_card_event.dart';
part 'edit_card_state.dart';

class EditCardBloc extends Bloc<EditCardEvent, EditCardState> {
  EditCardBloc() : super(EditCardInitial()) {
    on<EditCard>((event, emit) {
      // TODO: implement event handler
    });
  }
}
