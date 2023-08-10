import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<UserLogin>((event, emit) async {
      emit(LoginPending());
      final auth = FirebaseAuth.instance;
      try {
        final userCredential = await auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        final user = userCredential.user;
        print('User logged in: $user');
        emit(LoginSuccess());
      } on FirebaseAuthException catch (e) {
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
