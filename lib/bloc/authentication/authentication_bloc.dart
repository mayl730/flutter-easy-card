import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easy_card/core/service/firebase_auth_service.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> with ChangeNotifier {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<CheckAuthentication>((event, emit) async {
      emit(AuthenticationChecking());
      try {
        final user = await event.authService.getCurrentUser();
        if (user != null) {
          emit(AuthenticationLoggedIn());
        } else {
          emit(AuthenticationLoggedOut());
        }
      } catch (e) {
        emit(AuthenticationFail(error: e.toString()));
      }
       notifyListeners();
    });
  }
}
