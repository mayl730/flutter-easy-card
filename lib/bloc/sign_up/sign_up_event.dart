part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class CreateUser extends SignUpEvent {
  final String email;
  final String password;

  const CreateUser({
    required this.email,
    required this.password,
  });
}
