import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/bloc/logout/logout_bloc.dart';
import 'package:flutter_easy_card/bloc/settings/settings_bloc.dart';
import 'package:flutter_easy_card/core/service/firebase_auth_service.dart';
import 'package:flutter_easy_card/main.dart';
import 'package:flutter_easy_card/theme.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen(
      {super.key,
      required this.settingsBloc,
      required this.authService,
      required this.logoutBloc});

  final SettingsBloc settingsBloc;
  final LogoutBloc logoutBloc;
  final AuthService authService;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    widget.settingsBloc.add(FetchUserInfo(authService: authService));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const Padding(
            padding: EdgeInsets.only(left: sidePadding),
            child: Icon(Icons.settings, size: 32, color: easyPurple),
          ),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Settings',
                style: appTitleStyle,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 20,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: () => {context.go("/home")},
                icon: const Column(
                  children: [
                    SizedBox(height: 5),
                    Icon(
                      Icons.home_filled,
                      color: inActiveGray,
                      size: 24,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(
                        color: inActiveGray,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                label: const Text(
                  '',
                ),
              ),
              TextButton.icon(
                onPressed: () => {context.go("/explore-cards")},
                icon: const Column(
                  children: [
                    SizedBox(height: 5),
                    Icon(
                      Icons.person_search_rounded,
                      color: inActiveGray,
                      size: 24,
                    ),
                    Text(
                      'Explore',
                      style: TextStyle(
                        color: inActiveGray,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                label: const Text(
                  '',
                ),
              ),
              TextButton.icon(
                onPressed: () => {},
                icon: const Column(
                  children: [
                    SizedBox(height: 5),
                    Icon(
                      Icons.settings,
                      color: easyPurple,
                      size: 24,
                    ),
                    Text(
                      'Settings',
                      style: TextStyle(
                        color: easyPurple,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                label: const Text(
                  '',
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocBuilder<SettingsBloc, SettingsState>(
                  bloc: widget.settingsBloc,
                  builder: (context, state) {
                    if (state is SettingsPending) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is SettingsFailure) {
                      return Text(state.message);
                    }
                    if (state is SettingsSuccess) {
                      final user = state.user;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'UserID: ${user!.uid}',
                            style: titleH1TextStyle,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            user.email ?? '',
                            style: subContentStyle,
                          ),
                        ],
                      );
                    }

                    return Container();
                  }),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: BlocConsumer<LogoutBloc, LogoutState>(
                bloc: widget.logoutBloc,
                listener: (context, state) {
                  if (state is LogoutPending) {
                    EasyLoading.show(status: 'Loading...');
                  }
                  if (state is LogoutSuccess) {
                    EasyLoading.dismiss();
                    EasyLoading.showSuccess(
                        duration: const Duration(seconds: 2),
                        'Logout Success!');
                    context.go('/');
                  }
                  if (state is LogoutFailure) {
                    EasyLoading.dismiss();
                    EasyLoading.showError(state.message,
                        duration: const Duration(seconds: 2));
                  }
                },
                builder: (context, state) {
                  return TextButton(
                      onPressed: () {
                        widget.logoutBloc.add(
                            LogoutRequest(authService: widget.authService));
                      },
                      child: Text('Logout',
                          style: customTextButton(color: Colors.red)));
                },
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
          ],
        )));
  }
}
