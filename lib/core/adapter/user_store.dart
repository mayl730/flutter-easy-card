import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easy_card/core/provider/user_store.dart' as provider;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserStore implements provider.UserStore {
  static const String displayName = 'display_name';
  static const String photoUrl = 'photo_url';
  static const String email = 'email';
  static const String emailVerified = 'email_verified';
  static const String isAnonymous = 'is_anonymous';
  static const String phoneNumber = 'phone_number';
  static const String photoURL = 'photo_url';
  static const String refreshToken = 'refresh_token';
  static const String tenantId = 'tenant_id';
  static const String uid = 'uid';
  static const secureStorage = FlutterSecureStorage();
  
  @override
  Future<User?> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<String> readPasswordFromSecureStorage() {
    // TODO: implement readPasswordFromSucureStorage
    throw UnimplementedError();
  }

  @override
  Future removeUser() {
    // TODO: implement removeUser
    throw UnimplementedError();
  }

  @override
  savePasswordToSecureStorage(String password) {
    // TODO: implement savePasswordToSecureStorage
    throw UnimplementedError();
  }

  @override
  setToken(String token) {
    // TODO: implement setToken
    throw UnimplementedError();
  }

  @override
  Future setUser(User u) {
    // TODO: implement setUser
    throw UnimplementedError();
  }
}
