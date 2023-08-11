import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/bloc/create_card/create_card_bloc.dart';
import 'package:flutter_easy_card/bloc/login/login_bloc.dart';
import 'package:flutter_easy_card/bloc/sign_up/sign_up_bloc.dart';
import 'package:flutter_easy_card/home/ui/screens/explore_card_screen.dart';
import 'package:flutter_easy_card/home/ui/screens/home_screen.dart';
import 'package:flutter_easy_card/my_cards/ui/screens/create_card_screen.dart';
import 'package:flutter_easy_card/my_cards/ui/screens/my_card_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
          // builder: (context, state) => const StartScreen(),
          builder: (context, state) => BlocProvider(
            create: (context) => CreateCardBloc(),
            child: const CreateCardScreen(),
          ),
          routes: [
            GoRoute(
              path: 'sign-up',
              builder: (context, state) => BlocProvider(
                create: (context) => SignUpBloc(),
                child: const SignUpScreen(),
              ),
            ),
            GoRoute(
              path: 'login',
              builder: (context, state) => BlocProvider(
                create: (context) => LoginBloc(),
                child: const LoginScreen(),
              ),
            ),
            GoRoute(
                path: 'home',
                pageBuilder: (context, state) => NoTransitionPage<void>(
                      key: state.pageKey,
                      child: const HomeScreen(),
                    ),
                routes: [
                  GoRoute(
                    path: 'create-card',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      transitionDuration: const Duration(milliseconds: 300),
                      child: const CreateCardScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              SlideTransition(
                                  position: animation.drive(
                                    Tween<Offset>(
                                      begin: const Offset(0, 1),
                                      end: Offset.zero,
                                    ).chain(CurveTween(curve: Curves.easeIn)),
                                  ),
                                  child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'my-card-details',
                    builder: (context, state) => const MyCardDetailsScreen(),
                  ),
                ]),
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
      builder: EasyLoading.init(),
    );
  }
}
