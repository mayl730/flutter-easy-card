import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easy_card/core/service/firebase_auth_service.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<LogoutRequest>((event, emit) async {
      emit(LogoutPending());
      try {
        await event.authService.signOut();
        emit(LogoutSuccess());
      } catch (e) {
        emit(LogoutFailure(e.toString()));
      }
    });
  }
}
