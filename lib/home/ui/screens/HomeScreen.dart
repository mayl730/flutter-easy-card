import 'package:flutter/material.dart';
import 'package:flutter_easy_card/theme.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(left: sidePadding),
          child: Icon(Icons.home_filled, size: 32, color: easyPurple),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Your Cards',
              style: appTitleStyle,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1, 
              blurRadius: 20, 
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              iconSize: 24,
              icon: const Icon(Icons.home_filled),
              onPressed: () {
                context.push("/home");
              },
              color: black,
            ),
            TextButton.icon(
              onPressed: () => {},
              icon: Column(
                children: [
                  Icon(
                    Icons.home_filled,
                    color: black,
                    size: 24,
                  ),
                  Text(
                    'Label',
                    style: TextStyle(
                      color: black,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              label: Text(
                '', //'Label',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            IconButton(
              iconSize: 24,
              icon: const Icon(Icons.home_outlined),
              onPressed: () {
                context.push("/");
              },
              color: Colors.black,
            ),
            IconButton(
              iconSize: 24,
              icon: const Icon(Icons.home_outlined),
              onPressed: () {
                context.push("/");
              },
              color: Colors.black,
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sidePadding),
        child: Text('items'),
      ))),
    );
  }
}
