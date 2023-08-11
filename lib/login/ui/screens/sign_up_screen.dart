import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/bloc/sign_up/sign_up_bloc.dart';
import 'package:flutter_easy_card/components/custom_action_button.dart';
import 'package:flutter_easy_card/core/utils/form_validator.dart';
import 'package:flutter_easy_card/theme.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
          elevation: 0,
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
                          keyboardType: TextInputType.emailAddress,
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
                        BlocConsumer<SignUpBloc, SignUpState>(
                          bloc: BlocProvider.of<SignUpBloc>(context),
                          listener: (context, state) {
                            if (state is SignUpPending) {
                              EasyLoading.show(status: 'Loading...');
                            }
                            if (state is SignUpSuccess) {
                              EasyLoading.dismiss();
                              EasyLoading.showSuccess(
                                  duration: const Duration(seconds: 2),
                                  'Account created!');
                              context.go("/home");
                            }
                            if (state is SignUpFailure) {
                              EasyLoading.dismiss();
                              EasyLoading.showError(state.error,
                                  duration: const Duration(seconds: 2));
                            }
                          },
                          builder: (context, state) {
                            return CustomActionButton(
                              label: 'Sign Up',
                              onPressed: () async {
                                debugPrint('yourMessage');
                                if (formKey.currentState!.saveAndValidate()) {
                                  final formData = formKey.currentState!.value;
                                  BlocProvider.of<SignUpBloc>(context)
                                      .add(CreateUser(
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
