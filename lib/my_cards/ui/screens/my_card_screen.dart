import 'package:flutter/material.dart';
import 'package:flutter_easy_card/components/custom_action_button.dart';
import 'package:flutter_easy_card/theme.dart';
import 'package:go_router/go_router.dart';

class MyCardDetailsScreen extends StatefulWidget {
  const MyCardDetailsScreen({super.key});

  @override
  State<MyCardDetailsScreen> createState() => _MyCardDetailsScreenState();
}

class _MyCardDetailsScreenState extends State<MyCardDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: IconButton(
            icon: const Icon(
              Icons.close,
              color: black,
              size: 32,
            ),
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'My Card Details',
              style: appTitleStyle,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: sidePadding),
            child: Text('Card content'),
          ),
        ),
      ),
    );
  }
}
