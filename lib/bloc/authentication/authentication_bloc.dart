import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easy_card/core/adapter/user_store.dart';
import 'package:flutter_easy_card/core/service/firebase_auth_service.dart';
import 'package:flutter_easy_card/core/types/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>
    with ChangeNotifier {
  final UserStore userStore;
  AuthenticationBloc({required this.userStore})
      : super(AuthenticationInitial()) {
    on<CheckAuthentication>((event, emit) async {
      emit(AuthenticationChecking());
      try {
        User? user = await userStore.getUser();
        if (user != null) {
          emit(AuthenticationLoggedIn());
        }
      } catch (e) {
        emit(AuthenticationFail(error: e.toString()));
      }
      notifyListeners();
    });

    on<LogoutAuthentication>((event, emit) async {
      emit(AuthenticationLoggedOut());
    });
  }
}
