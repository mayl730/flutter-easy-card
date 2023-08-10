part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class UserSignUp extends SignUpEvent {
  final String email;
  final String password;

  const UserSignUp({
    required this.email,
    required this.password,
  });
}
