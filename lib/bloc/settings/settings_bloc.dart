import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/core/adapter/user_store.dart';
import 'package:flutter_easy_card/core/service/firebase_auth_service.dart';
import 'package:flutter_easy_card/core/types/user.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final UserStore userStore;
  SettingsBloc({required this.userStore}) : super(SettingsInitial()) {
    on<FetchUserInfo>((event, emit) async {
      emit(SettingsPending());
      try {
        User? user = await userStore.getUser();
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