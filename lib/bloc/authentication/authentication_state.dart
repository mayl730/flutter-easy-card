part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationPending extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {}

class AuthenticationFail extends AuthenticationState {
  final String error;
  const AuthenticationFail({required this.error});
}
