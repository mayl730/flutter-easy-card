import 'package:flutter/material.dart';
import 'package:flutter_easy_card/components/circle_icon.dart';
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
          child: Column(
            children: [
              Container(
                height: 240,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        NetworkImage("https://dummyimage.com/600x600/000/fff"),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('John Doe',
                  style: titleH1TextStyle, textAlign: TextAlign.center),
              const Text('Software Engineer', style: appTitleStyle),
              const Text('Random Studio', style: appTitleStyle),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: sidePadding),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleIcon(
                            iconData: Icons.email,
                            backgroundColor: easyPurple,
                            iconColor: Colors.white,
                          ),

                          Text(
                            'test@gmail.com',
                            textAlign: TextAlign.left,
                            style: contentStyle,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CircleIcon(
                            iconData: Icons.phone,
                            backgroundColor: easyPurple,
                            iconColor: Colors.white,
                          ),
                          Text(
                            '123456789',
                            textAlign: TextAlign.left,
                            style: contentStyle,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}




//  padding: EdgeInsets.symmetric(horizontal: sidePadding),