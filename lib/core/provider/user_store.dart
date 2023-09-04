import 'package:firebase_auth/firebase_auth.dart';

abstract class UserStore {
  Future setUser(User u);
  Future<String> readPasswordFromSucureStorage();
  savePasswordToSecureStorage(String password);
  Future removeUser();
  Future<User?> getUser();
  setToken(String token);
}
