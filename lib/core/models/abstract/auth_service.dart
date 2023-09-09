import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Future<User?> getCurrentUser();
  Future<void> signOut();
}