import 'package:flutter/material.dart';

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
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.0,
              ),
              Image.asset(
                'assets/images/2.0x/img_logo.png',
                width: screenWidth * 0.6,
                scale: 2.0,
              ),
              Image.asset(
                'assets/images/2.0x/img_onboarding_card.png',
                width: screenWidth,
                scale: 2.0,
              ),
              Text('Make name card & Share it quick!'),
            ],
          ),
        )),
      ),
    );
  }
}
