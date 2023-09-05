import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter_easy_card/core/provider/user_store.dart' as provider;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserStore implements provider.UserStore {
  static const String displayNameKey = 'display_name';
  static const String photoUrlKey = 'photo_url';
  static const String emailKey = 'email';
  static const String emailVerifiedKey = 'email_verified';
  static const String isAnonymousKey = 'is_anonymous';
  static const String phoneNumberKey = 'phone_number';
  static const String photoURLKey = 'photo_url';
  static const String refreshTokenKey = 'refresh_token';
  static const String tenantIdKey = 'tenant_id';
  static const String uidKey = 'uid';
  static const secureStorage = FlutterSecureStorage();

  @override
  Future<firebase.User?> getUser() async {
    final pref = await SharedPreferences.getInstance();

    final displayName = pref.getString(displayNameKey);
    final photoUrl = pref.getString(photoUrlKey);
    final email = pref.getString(emailKey);
    final emailVerified = pref.getBool(emailVerifiedKey);
    final isAnonymous = pref.getBool(isAnonymousKey);
    final phoneNumber = pref.getString(phoneNumberKey);
    final refreshToken = pref.getString(refreshTokenKey);
    final tenantId = pref.getString(tenantIdKey);
    final uid = pref.getString(uidKey);

    // return User(
    //   displayName: displayName,
    //   photoURL: photoUrl,
    //   email: email,
    //   emailVerified: emailVerified!,
    //   isAnonymous: isAnonymous!,
    //   phoneNumber: phoneNumber,
    //   refreshToken: refreshToken,
    //   tenantId: tenantId,
    //   uid: uid,
    // );

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
  Future setUser(firebase.User u) async {
    final pref = await SharedPreferences.getInstance();

    await pref.setString(emailKey, u.email!);
    await pref.setString(uidKey, u.uid);
    await pref.setString(displayNameKey, u.displayName!);
    await pref.setString(photoUrlKey, u.photoURL!);
    await pref.setBool(emailVerifiedKey, u.emailVerified);
    await pref.setBool(isAnonymousKey, u.isAnonymous);
    await pref.setString(phoneNumberKey, u.phoneNumber!);
    await pref.setString(refreshTokenKey, u.refreshToken!);
    await pref.setString(tenantIdKey, u.tenantId!);
    await pref.setString(uidKey, u.uid);  
  }
}
