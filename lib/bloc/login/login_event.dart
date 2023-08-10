part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class UserLogin extends LoginEvent {
  final String email;
  final String password;

  const UserLogin({
    required this.email,
    required this.password,
  });
}
