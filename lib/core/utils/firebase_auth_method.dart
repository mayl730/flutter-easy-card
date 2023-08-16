import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<bool> isUserLoggedIn() async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  } catch (e) {
    debugPrint("Error checking user login status: $e");
    return false;
  }
}