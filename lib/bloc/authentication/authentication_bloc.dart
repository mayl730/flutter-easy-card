import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easy_card/core/utils/firebase_auth_method.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<CheckAuthentication>((event, emit) async {
    
    });
  }
}
