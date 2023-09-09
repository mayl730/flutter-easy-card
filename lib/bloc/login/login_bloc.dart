import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easy_card/core/adapter/user_store.dart';
import 'package:flutter_easy_card/core/service/firebase_auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserStore userStore;
  final AuthService authService;
  LoginBloc({required this.userStore, required this.authService})
      : super(LoginInitial()) {
    on<UserLogin>((event, emit) async {
      emit(LoginPending());
      try {
        final userCredential = await authService.signIn(
          email: event.email,
          password: event.password,
        );
        final user = userCredential.user!;
        await userStore.setUser(user);
        emit(LoginSuccess());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          emit(const LoginFailure(error: 'No user found for that email.'));
        } else if (e.code == 'wrong-password') {
          emit(const LoginFailure(
              error: 'Wrong password provided for that user.'));
        }
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
