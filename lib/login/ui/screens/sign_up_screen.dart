import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
       extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Center(
          child: Text('Sign Up Screen'),
        ),
      ),);
  }
}
