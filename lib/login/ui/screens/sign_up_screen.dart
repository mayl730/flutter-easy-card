import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/bloc/sign_up/sign_up_bloc.dart';
import 'package:flutter_easy_card/components/custom_action_button.dart';
import 'package:flutter_easy_card/theme.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final FocusNode _emailFieldFocus = FocusNode();
  final FocusNode _passwordFieldFocus = FocusNode();

  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;

  @override
  void dispose() {
    _emailFieldFocus.dispose();
    _passwordFieldFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0, // No drop shadow
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: black,
            ),
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: sidePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sign Up',
                    style: titleH1TextStyle,
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const Text('Please Sign Up to continue using Easy Card!',
                      style: subContentStyle),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const SizedBox(height: 8),
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FormBuilderTextField(
                            name: 'email',
                            onChanged: (val) {
                              email = val;
                            },
                            onTap: () {
                              _emailFieldFocus.requestFocus();
                            },
                            focusNode: _emailFieldFocus,
                            decoration: loginInputDecoration,
                            keyboardType: TextInputType.emailAddress),
                        const SizedBox(height: 20),
                        const Text(
                          'Password',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        FormBuilderTextField(
                            name: 'password',
                            obscureText: true,
                            onChanged: (val) {
                              password = val;
                            },
                            onTap: () {
                              _passwordFieldFocus.requestFocus();
                            },
                            focusNode: _passwordFieldFocus,
                            decoration: loginInputDecoration),
                        const SizedBox(height: 30),
                        BlocConsumer<SignUpBloc, SignUpState>(
                          bloc: BlocProvider.of<SignUpBloc>(context),
                          listener: (context, state) {
                            if (state is SignUpSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Account created!'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              context.go("/home");
                            }
                            if (state is SignUpFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.error),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return CustomActionButton(
                              label: 'Sign Up',
                              onPressed: () async {
                                // print('Email: $email Password: $password');
                                // await _auth
                                //     .createUserWithEmailAndPassword(
                                //         email: email!, password: password!)
                                //     .then((value) {
                                //   print('User created: $value');
                                //   // context.push("/home");
                                //   context.go("/home");
                                // }).catchError((error) {
                                //   print('Error: $error');
                                // });
                                BlocProvider.of<SignUpBloc>(context)
                                    .add(CreateUser(
                                  email: email!,
                                  password: password!,
                                ));
                                // context.go("/home");
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            text: 'Already have an account? ',
                            style: const TextStyle(fontSize: 14),
                            children: [
                              TextSpan(
                                text: 'Login here.',
                                style: const TextStyle(
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                  color: easyPurple,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.push("/login");
                                  },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
