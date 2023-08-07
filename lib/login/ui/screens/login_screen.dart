import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_card/theme.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                width: screenWidth,
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
              SizedBox(
                width: screenWidth,
                child: ElevatedButton(
                  onPressed: () {
                    context.push("/sign-up");
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(16.0),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      easyPurple,
                    ),
                    elevation: MaterialStateProperty.all<double>(0),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.white,
                        size: 24.0,
                        semanticLabel: 'Email Icon',
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Continue with Email',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 35),
              const Text(
                'By continuing you argree to our Terms of Service and Privacy Policy.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
