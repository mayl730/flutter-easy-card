import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/bloc/login/login_bloc.dart';
import 'package:flutter_easy_card/components/custom_action_button.dart';
import 'package:flutter_easy_card/core/utils/form_validator.dart';
import 'package:flutter_easy_card/theme.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  final Map<String, FocusNode> _fieldFocusNodes = {
    'email': FocusNode(),
    'password': FocusNode(),
  };

  @override
  void dispose() {
    for (var focusNode in _fieldFocusNodes.values) {
      focusNode.dispose();
    }
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
                    'Login',
                    style: titleH1TextStyle,
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const Text('Login with your existing account.',
                      style: subContentStyle),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const SizedBox(height: 8),
                  FormBuilder(
                    key: formKey,
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
                          onTap: () {
                            _fieldFocusNodes['email']!.requestFocus();
                          },
                          focusNode: _fieldFocusNodes['email'],
                          decoration: loginInputDecoration,
                          validator: validateEmail,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Password',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        FormBuilderTextField(
                          name: 'password',
                          obscureText: true,
                          onTap: () {
                            _fieldFocusNodes['password']!.requestFocus();
                          },
                          focusNode: _fieldFocusNodes['password'],
                          decoration: loginInputDecoration,
                          validator: validatePassword,
                        ),
                        const SizedBox(height: 30),
                        BlocConsumer<LoginBloc, LoginState>(
                          bloc: BlocProvider.of<LoginBloc>(context),
                          listener: (context, state) {
                            if (state is LoginPending) {
                              EasyLoading.show(status: 'Loading...');
                            }
                            if (state is LoginSuccess) {
                              EasyLoading.dismiss();
                              EasyLoading.showSuccess(
                                  duration: const Duration(seconds: 2),
                                  'Login Success!');
                              context.go("/home");
                            }
                            if (state is LoginFailure) {
                              EasyLoading.dismiss();
                              EasyLoading.showError(state.error,
                                  duration: const Duration(seconds: 2));
                            }
                          },
                          builder: (context, state) {
                            return CustomActionButton(
                              label: 'Login',
                              onPressed: () async {
                                if (formKey.currentState!.saveAndValidate()) {
                                  final formData = formKey.currentState!.value;
                                  BlocProvider.of<LoginBloc>(context)
                                      .add(UserLogin(
                                    email: formData['email']!,
                                    password: formData['password']!,
                                  ));
                                }
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            text: 'Don\'t have an account? ',
                            style: const TextStyle(fontSize: 14),
                            children: [
                              TextSpan(
                                text: 'Register here.',
                                style: const TextStyle(
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                  color: easyPurple,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.push("/sign-up");
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
