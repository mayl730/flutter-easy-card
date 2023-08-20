part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}


class FetchUserInfo extends SettingsEvent {
final AuthService authService;

const FetchUserInfo({required this.authService});
}