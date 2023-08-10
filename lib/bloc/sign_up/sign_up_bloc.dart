import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<UserSignUp>((event, emit) async {
      emit(SignUpPending());
        final auth = FirebaseAuth.instance;
        try {
          final userCredential = await auth.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          final user = userCredential.user;
          print('User created: $user');
          emit(SignUpSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            emit(const SignUpFailure(error: 'The password provided is too weak.'));
          } else if (e.code == 'email-already-in-use') {
            emit(const SignUpFailure(error: 'The account already exists for that email.'));
          }
        } catch (e) {
          emit(SignUpFailure(error: e.toString()));
        }
    });
  }
}
