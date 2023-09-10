import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easy_card/core/adapter/user_store.dart';
import 'package:flutter_easy_card/core/service/firebase_auth_service.dart';
import 'package:flutter_easy_card/core/service/firebase_collection_service.dart';
import 'package:flutter_easy_card/core/service/firebase_storage_service.dart';
import 'package:flutter_easy_card/main_app.dart';

final AuthService authService = AuthService();
final FirebaseStorageService firebaseStorageService = FirebaseStorageService();
final FirebaseCollectionService firebaseCollectionService =
    FirebaseCollectionService();
final UserStore userStore = UserStore();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp(
    authService: authService,
    firebaseStorageService: firebaseStorageService,
    firebaseCollectionService: firebaseCollectionService,
    userStore: userStore,
  ));
}
