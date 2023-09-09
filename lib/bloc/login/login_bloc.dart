import 'package:firebase_auth/firebase_auth.dart' as firebase;
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
      final auth = firebase.FirebaseAuth.instance;
      try {
        final userCredential = await auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        firebase.User? user = userCredential.user;

        if (user != null) {
          userStore.setUser(user);
          emit(LoginSuccess());
        } else {
          emit(const LoginFailure(error: 'User is null'));
        }
      } on firebase.FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          emit(const LoginFailure(error: 'Wrong password! Please try again.'));
        } else if (e.code == 'wrong-password') {
          emit(const LoginFailure(error: 'Wrong password! Please try again.'));
        }
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
