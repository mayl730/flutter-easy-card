import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_easy_card/bloc/card_details/card_details_bloc.dart';
import 'package:flutter_easy_card/bloc/create_card/create_card_bloc.dart';
import 'package:flutter_easy_card/bloc/login/login_bloc.dart';
import 'package:flutter_easy_card/bloc/my_cards/my_cards_bloc.dart';
import 'package:flutter_easy_card/bloc/sign_up/sign_up_bloc.dart';
import 'package:flutter_easy_card/home/ui/screens/explore_card_screen.dart';
import 'package:flutter_easy_card/home/ui/screens/home_screen.dart';
import 'package:flutter_easy_card/my_cards/ui/screens/create_card_screen.dart';
import 'package:flutter_easy_card/my_cards/ui/screens/edit_card_screen.dart';
import 'package:flutter_easy_card/my_cards/ui/screens/my_card_details_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';

import 'package:flutter_easy_card/login/ui/screens/start_screen.dart';
import 'package:flutter_easy_card/login/ui/screens/sign_up_screen.dart';
import 'package:flutter_easy_card/login/ui/screens/login_screen.dart';

final myCardsBloc = MyCardsBloc();
final myCardDetailsBloc = CardDetailsBloc();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // MyApp({Key? key})
  //     : authenticationBloc = AuthenticationBloc()..add(CheckAuthentication()),
  //       super(key: key);

  // final AuthenticationBloc authenticationBloc;
  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            // return const StartScreen();
            return BlocProvider<MyCardsBloc>(
              create: (context) => myCardsBloc,
              child: HomeScreen(myCardsBloc: myCardsBloc),
            );
          },
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
                    child: BlocProvider<MyCardsBloc>(
                      create: (context) => myCardsBloc,
                      child: HomeScreen(myCardsBloc: myCardsBloc),
                    )),
                routes: [
                  GoRoute(
                    path: 'create-card',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      transitionDuration: const Duration(milliseconds: 300),
                      child: BlocProvider(
                        create: (context) => CreateCardBloc(),
                        child: const CreateCardScreen(),
                      ),
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
                    path: 'my-card-details/:cardId',
                    builder: (context, state) {
                      final String cardId = state.pathParameters['cardId']!;
                      return BlocProvider<CardDetailsBloc>(
                        create: (context) => myCardDetailsBloc,
                        child: MyCardDetailsScreen(cardId: cardId, myCardDetailsBloc: myCardDetailsBloc),
                      );
                    },
                  ),
                  GoRoute(
                    path: 'edit-card/:cardId',
                    builder: (context, state) {
                      final String cardId = state.pathParameters['cardId']!;
                      return BlocProvider<CardDetailsBloc>(
                        create: (context) => myCardDetailsBloc,
                        child: EditCardScreen(cardId: cardId, myCardDetailsBloc: myCardDetailsBloc),
                      );
                    },
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
