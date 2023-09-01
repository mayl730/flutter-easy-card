part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthentication extends AuthenticationEvent {
  final AuthService authService;
  const CheckAuthentication({required this.authService});
}
class LogoutAuthentication extends AuthenticationEvent {
  const LogoutAuthentication();
}
