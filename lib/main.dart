import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/core/adapter/user_store.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';

import 'package:flutter_easy_card/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_easy_card/bloc/card_details/card_details_bloc.dart';
import 'package:flutter_easy_card/bloc/create_card/create_card_bloc.dart';
import 'package:flutter_easy_card/bloc/edit_card/edit_card_bloc.dart';
import 'package:flutter_easy_card/bloc/explore_cards/explore_cards_bloc.dart';
import 'package:flutter_easy_card/bloc/delete_card/delete_card_bloc.dart';
import 'package:flutter_easy_card/bloc/load_saved_cards/load_saved_cards_bloc.dart';
import 'package:flutter_easy_card/bloc/login/login_bloc.dart';
import 'package:flutter_easy_card/bloc/logout/logout_bloc.dart';
import 'package:flutter_easy_card/bloc/my_cards/my_cards_bloc.dart';
import 'package:flutter_easy_card/bloc/save_card/save_card_bloc.dart';
import 'package:flutter_easy_card/bloc/settings/settings_bloc.dart';
import 'package:flutter_easy_card/bloc/sign_up/sign_up_bloc.dart';
import 'package:flutter_easy_card/core/service/firebase_auth_service.dart';
import 'package:flutter_easy_card/home/ui/screens/explore_cards/explore_cards_screen.dart';
import 'package:flutter_easy_card/home/ui/screens/explore_cards/other_card_details_screen.dart';
import 'package:flutter_easy_card/home/ui/screens/my_cards/create_card_screen.dart';
import 'package:flutter_easy_card/home/ui/screens/my_cards/edit_card_screen.dart';
import 'package:flutter_easy_card/home/ui/screens/my_cards/my_card_details_screen.dart';
import 'package:flutter_easy_card/home/ui/screens/my_cards/my_cards_screen.dart';
import 'package:flutter_easy_card/home/ui/screens/saved_cards/saved_cards_screen.dart';
import 'package:flutter_easy_card/home/ui/screens/settings/settings_screen.dart';
import 'package:flutter_easy_card/login/ui/screens/start_screen.dart';
import 'package:flutter_easy_card/login/ui/screens/sign_up_screen.dart';
import 'package:flutter_easy_card/login/ui/screens/login_screen.dart';

AuthService authService = AuthService();
UserStore userStore = UserStore();

final authenticationBloc = AuthenticationBloc();
final myCardsBloc = MyCardsBloc();
final myCardDetailsBloc = CardDetailsBloc();
final createCardBloc = CreateCardBloc();
final editCardBloc = EditCardBloc();
final deleteCardBloc = DeleteCardBloc();
final settingsBloc = SettingsBloc();
final loginBloc = LoginBloc(userStore: userStore);
final logoutBloc = LogoutBloc();
final exploreCardsBloc = ExploreCardsBloc();
final loadSavedCardsBloc = LoadSavedCardsBloc();
final saveCardBloc = SaveCardBloc();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    authenticationBloc.add(CheckAuthentication(authService: authService));
  }

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return const StartScreen();
          },
          redirect: (
            BuildContext context,
            GoRouterState state,
          ) {
            final appState = authenticationBloc.state;
            if (appState is AuthenticationLoggedIn &&
                state.uri == Uri(path: '/')) {
              return '/home';
            }
            return null;
          },
          routes: [
            GoRoute(
              path: 'sign-up',
              builder: (context, state) => BlocProvider(
                create: (context) => SignUpBloc(),
                child: const SignUpScreen(),
              ),
              redirect: (BuildContext context, GoRouterState state) {
                final appState = authenticationBloc.state;
                if (appState is AuthenticationLoggedIn &&
                    state.uri == Uri(path: '/')) {
                  return '/home';
                }
                return null;
              },
            ),
            GoRoute(
              path: 'login',
              builder: (context, state) => BlocProvider(
                create: (context) => loginBloc,
                child: const LoginScreen(),
              ),
            ),
            GoRoute(
                path: 'home',
                pageBuilder: (context, state) => NoTransitionPage<void>(
                    key: state.pageKey,
                    child: MyCardsScreen(myCardsBloc: myCardsBloc)),
                routes: [
                  GoRoute(
                    path: 'create-card',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      transitionDuration: const Duration(milliseconds: 300),
                      child: CreateCardScreen(createCardBloc: createCardBloc),
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
                      return MyCardDetailsScreen(
                        cardId: cardId,
                        cardDetailsBloc: myCardDetailsBloc,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'edit-card/:cardId',
                    builder: (context, state) {
                      final String cardId = state.pathParameters['cardId']!;
                      return EditCardScreen(
                        cardId: cardId,
                        myCardDetailsBloc: myCardDetailsBloc,
                        editCardBloc: editCardBloc,
                        deleteCardBloc: deleteCardBloc,
                      );
                    },
                  ),
                ]),
            GoRoute(
              path: 'explore-cards',
              pageBuilder: (context, state) => NoTransitionPage<void>(
                  key: state.pageKey,
                  child:
                      ExploreCardsScreen(exploreCardsBloc: exploreCardsBloc)),
              routes: [
                GoRoute(
                  path: 'other-card-details/:cardId',
                  builder: (context, state) {
                    final String cardId = state.pathParameters['cardId']!;
                    return OtherCardDetailsScreen(
                      cardId: cardId,
                      cardDetailsBloc: myCardDetailsBloc,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: 'saved-cards',
              pageBuilder: (context, state) => NoTransitionPage<void>(
                  key: state.pageKey,
                  child: SavedCardsScreen(savedCardsBloc: loadSavedCardsBloc)),
              routes: [
                GoRoute(
                  path: 'other-card-details/:cardId',
                  builder: (context, state) {
                    final String cardId = state.pathParameters['cardId']!;
                    return OtherCardDetailsScreen(
                      cardId: cardId,
                      cardDetailsBloc: myCardDetailsBloc,
                    );
                  },
                ),
              ],
            ),
            GoRoute(
                path: 'settings',
                pageBuilder: (context, state) => NoTransitionPage<void>(
                      key: state.pageKey,
                      child: SettingsScreen(
                          settingsBloc: settingsBloc,
                          logoutBloc: logoutBloc,
                          authService: authService),
                    )),
          ],
        ),
      ],
    );
    return BlocProvider(
      create: (context) => authenticationBloc,
      child: MaterialApp.router(
        routerConfig: router,
        builder: EasyLoading.init(),
      ),
    );
  }
}
