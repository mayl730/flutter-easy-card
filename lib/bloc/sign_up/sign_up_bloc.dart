import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter_easy_card/core/adapter/user_store.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  UserStore userStore;
  SignUpBloc({required this.userStore}) : super(SignUpInitial()) {
    on<CreateUser>((event, emit) async {
      emit(SignUpPending());
      final auth = firebase.FirebaseAuth.instance;
      try {
        final userCredential = await auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        final firebase.User firebaseUser = userCredential.user!;

        await userStore.setUser(firebaseUser);

        emit(SignUpSuccess());
      } on firebase.FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          emit(
              const SignUpFailure(error: 'The password provided is too weak.'));
        } else if (e.code == 'email-already-in-use') {
          emit(const SignUpFailure(
              error: 'The account already exists for that email.'));
        }
      } catch (e) {
        emit(SignUpFailure(error: e.toString()));
      }
    });
  }
}
