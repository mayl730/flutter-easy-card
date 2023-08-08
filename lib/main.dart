import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easy_card/home/ui/screens/ExploreCardScreen.dart';
import 'package:flutter_easy_card/home/ui/screens/HomeScreen.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';

import 'package:flutter_easy_card/login/ui/screens/start_screen.dart';
import 'package:flutter_easy_card/login/ui/screens/sign_up_screen.dart';
import 'package:flutter_easy_card/login/ui/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'sign-up',
              builder: (context, state) => const SignUpScreen(),
            ),
            GoRoute(
              path: 'login',
              builder: (context, state) => const LoginScreen(),
            ),
            GoRoute(
              path: 'home',
              pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: const HomeScreen(),
              ),
            ),
            GoRoute(
              path: 'explore-cards',
              pageBuilder: (context, state) => NoTransitionPage<void>(
                key: state.pageKey,
                child: const ExploreCardScreen(),
              ),
            ),
          ],
        ),
      ],
    );
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
