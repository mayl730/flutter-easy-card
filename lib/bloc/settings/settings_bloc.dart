import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/core/service/firebase_auth_service.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<FetchUserInfo>((event, emit) async {
      emit(SettingsPending());
      try {
        User? user = await event.authService.getCurrentUser();

        if (user != null) {
          emit(SettingsSuccess(user));
        } else {
          emit(const SettingsFailure('No user signed in.'));
        }
     
      } catch (e) {
        emit(SettingsFailure(e.toString()));
      }
    });
  }
}
