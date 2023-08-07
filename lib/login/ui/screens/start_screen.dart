import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_card/components/custom_action_button.dart';
import 'package:flutter_easy_card/theme.dart';
import 'package:go_router/go_router.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: sidePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25.0,
              ),
              Image.asset(
                'assets/images/2.0x/img_logo.png',
                width: screenWidth * 0.6,
                scale: 2.0,
              ),
              const SizedBox(
                height: 25.0,
              ),
              Image.asset(
                'assets/images/2.0x/img_onboarding_card.png',
                width: double.infinity,
                scale: 2.0,
              ),
              const AutoSizeText(
                'Create and Share Name Cards Swiftly!',
                style: titleH1TextStyle,
                maxLines: 2,
              ),
              const SizedBox(
                height: 35.0,
              ),
              CustomActionButton(
                label: 'Continue with Email',
                onPressed: () {
                  context.push("/sign-up");
                },
                icon: Icons.email,
              ),
              const SizedBox(height: 35),
              const Text(
                'By continuing you agree to our Terms of Service and Privacy Policy.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
