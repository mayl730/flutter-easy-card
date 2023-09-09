import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter_easy_card/core/types/user.dart' as core;

abstract class UserStore {
  Future setUser(firebase.User u);
  Future removeUser();
  Future<core.User?> getUser();
}