part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationChecking extends AuthenticationState {}

class AuthenticationLoggedIn extends AuthenticationState {}

class AuthenticationLoggedOut extends AuthenticationState {}

class AuthenticationFail extends AuthenticationState {
  final String error;
  const AuthenticationFail({required this.error});
}
