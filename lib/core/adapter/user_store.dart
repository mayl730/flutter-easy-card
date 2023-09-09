import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter_easy_card/core/types/user.dart' as core;
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserStore {
  Future setUser(firebase.User u);
  Future removeUser();
  Future<core.User?> getUser();
  factory UserStore() => _UserStore();
}

class _UserStore implements UserStore {
  static const String displayNameKey = 'display_name';
  static const String photoUrlKey = 'photo_url';
  static const String emailKey = 'email';
  static const String emailVerifiedKey = 'email_verified';
  static const String isAnonymousKey = 'is_anonymous';
  static const String phoneNumberKey = 'phone_number';
  static const String refreshTokenKey = 'refresh_token';
  static const String tenantIdKey = 'tenant_id';
  static const String uidKey = 'uid';

  @override
  Future<core.User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    final displayName = prefs.getString(displayNameKey);
    final photoUrl = prefs.getString(photoUrlKey);
    final email = prefs.getString(emailKey);
    final emailVerified = prefs.getBool(emailVerifiedKey);
    final isAnonymous = prefs.getBool(isAnonymousKey);
    final phoneNumber = prefs.getString(phoneNumberKey);
    final refreshToken = prefs.getString(refreshTokenKey);
    final tenantId = prefs.getString(tenantIdKey);
    final uid = prefs.getString(uidKey);

    if (uid == null) {
      return null;
    }

    return core.User(
      displayName: displayName,
      photoURL: photoUrl,
      email: email,
      emailVerified: emailVerified,
      isAnonymous: isAnonymous,
      phoneNumber: phoneNumber,
      refreshToken: refreshToken,
      tenantId: tenantId,
      uid: uid,
    );
  }

  @override
  Future removeUser() async{
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.remove(emailKey);
    await prefs.remove(uidKey);
    await prefs.remove(displayNameKey);
    await prefs.remove(photoUrlKey);
    await prefs.remove(emailVerifiedKey);
    await prefs.remove(isAnonymousKey);
    await prefs.remove(phoneNumberKey);
    await prefs.remove(refreshTokenKey);
    await prefs.remove(tenantIdKey);
  }

  @override
  Future setUser(firebase.User u) async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setString(emailKey, u.email?? "");
    await prefs.setString(uidKey, u.uid);
    await prefs.setString(displayNameKey, u.displayName?? "");
    await prefs.setString(photoUrlKey, u.photoURL?? "");
    await prefs.setBool(emailVerifiedKey, u.emailVerified);
    await prefs.setBool(isAnonymousKey, u.isAnonymous);
    await prefs.setString(phoneNumberKey, u.phoneNumber?? "");
    await prefs.setString(refreshTokenKey, u.refreshToken?? "");
    await prefs.setString(tenantIdKey, u.tenantId?? "");
  }
}
