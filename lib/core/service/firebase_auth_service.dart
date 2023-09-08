import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easy_card/core/provider/auth_service.dart' as provider;


class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<User?> getCurrentUser() async {
    try {
      User? user = _auth.currentUser;
      return user;
    } catch (e) {
      debugPrint('Error fetching user: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint('Error signing out: $e');
    }
  }
}

// implements provider.AuthService