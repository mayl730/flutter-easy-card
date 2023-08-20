part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();
  
  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {}

final class SettingsPending extends SettingsState {}

final class SettingsSuccess extends SettingsState {
  final User? user;

  const SettingsSuccess(this.user);
}

final class SettingsFailure extends SettingsState {
  final String message;

  const SettingsFailure(this.message);

  @override
  List<Object> get props => [message];
}