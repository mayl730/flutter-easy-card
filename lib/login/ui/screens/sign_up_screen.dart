import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_card/components/custom_action_button.dart';
import 'package:flutter_easy_card/theme.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final FocusNode _emailFieldFocus = FocusNode();
  final FocusNode _passwordFieldFocus = FocusNode();

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
                            onChanged: (val) {},
                            onTap: () {
                              _emailFieldFocus.requestFocus();
                            },
                            focusNode: _emailFieldFocus,
                            decoration: loginInputDecoration),
                        const SizedBox(height: 20),
                        const Text(
                          'Password',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        FormBuilderTextField(
                            name: 'password',
                            obscureText: true,
                            onChanged: (val) {},
                            onTap: () {
                              _passwordFieldFocus.requestFocus();
                            },
                            focusNode: _passwordFieldFocus,
                            decoration: loginInputDecoration),
                        const SizedBox(height: 30),
                        CustomActionButton(
                          label: 'Sign Up',
                          onPressed: () {
                            context.go("/home");
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
