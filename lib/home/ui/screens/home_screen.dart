import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_card/core/utils/firebase_collection_method.dart';
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
    'Item 5',
    'Item 5',
    'Item 5',
    'Item 5',
    'Item 5',
    'Item 5',
    'Item 5',
    'Item 5',
    'Item 5',
    'Item 5',
    'Item 5',
    'Item 5',
  ];


  @override
  Widget build(BuildContext context) {
    fetchCardsByCreator("test6@gmail.com");
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/home/create-card');
        },
        label: const Text('Create Card'),
        icon: const Icon(Icons.add),
        backgroundColor: easyPurple,
      ),
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
              'My Cards',
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
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: () => {context.go("/home")},
              icon: const Column(
                children: [
                  SizedBox(height: 5),
                  Icon(
                    Icons.home_filled,
                    color: black,
                    size: 24,
                  ),
                  Text(
                    'Home',
                    style: TextStyle(
                      color: black,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              label: const Text(
                '',
              ),
            ),
            TextButton.icon(
              onPressed: () => {context.go("/explore-cards")},
              icon: const Column(
                children: [
                  SizedBox(height: 5),
                  Icon(
                    Icons.person_search_rounded,
                    color: inActiveGray,
                    size: 24,
                  ),
                  Text(
                    'Explore',
                    style: TextStyle(
                      color: inActiveGray,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              label: const Text(
                '',
              ),
            ),
            TextButton.icon(
              onPressed: () => {context.go("/home")},
              icon: const Column(
                children: [
                  SizedBox(height: 5),
                  Icon(
                    Icons.settings,
                    color: inActiveGray,
                    size: 24,
                  ),
                  Text(
                    'Settings',
                    style: TextStyle(
                      color: inActiveGray,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              label: const Text(
                '',
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 22,
            mainAxisSpacing: 22,
            crossAxisCount: 2,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                context.push('/home/my-card-details');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 12,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://dummyimage.com/600x600/000/fff"),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                        child:
                            Text(items[index], style: thumbnailCardTitleStyle)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
