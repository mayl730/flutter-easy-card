import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/core/adapter/user_store.dart';
import 'package:flutter_easy_card/core/service/firebase_auth_service.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final UserStore userStore;
  LogoutBloc({required this.userStore}) : super(LogoutInitial()) {
    on<LogoutRequest>((event, emit) async {
      emit(LogoutPending());
      try {
        await event.authService.signOut();
        await userStore.removeUser();
        emit(LogoutSuccess());
      } catch (e) {
        emit(LogoutFailure(e.toString()));
      }
    });
  }
}
