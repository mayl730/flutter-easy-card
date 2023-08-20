part of 'logout_bloc.dart';

sealed class LogoutEvent extends Equatable {
  const LogoutEvent();

  @override
  List<Object> get props => [];
}

class LogoutRequest extends LogoutEvent {
  final AuthService authService;

  const LogoutRequest({required this.authService});
}
