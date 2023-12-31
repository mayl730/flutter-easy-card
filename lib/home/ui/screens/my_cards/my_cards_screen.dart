import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/bloc/my_cards/my_cards_bloc.dart';
import 'package:flutter_easy_card/components/list_of_cards_thumbnails.dart';
import 'package:flutter_easy_card/theme.dart';
import 'package:go_router/go_router.dart';

class MyCardsScreen extends StatefulWidget {
  const MyCardsScreen({super.key, required this.myCardsBloc});
  final MyCardsBloc myCardsBloc;

  @override
  State<MyCardsScreen> createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends State<MyCardsScreen> {
  @override
  void initState() {
    super.initState();
    widget.myCardsBloc.add(FetchMyCards());
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: () => {},
              icon: const Column(
                children: [
                  SizedBox(height: 5),
                  Icon(
                    Icons.home_filled,
                    color: easyPurple,
                    size: 24,
                  ),
                  Text(
                    'Home',
                    style: TextStyle(
                      color: easyPurple,
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
              onPressed: () => {context.go("/saved-cards")},
              icon: const Column(
                children: [
                  SizedBox(height: 5),
                  Icon(
                    Icons.bookmark,
                    color: inActiveGray,
                    size: 24,
                  ),
                  Text(
                    'Saved',
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
              onPressed: () => {context.go("/settings")},
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
        child: BlocBuilder<MyCardsBloc, MyCardsState>(
          bloc: widget.myCardsBloc,
          builder: (context, state) {
            if (state is MyCardsPending) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MyCardsSuccess) {
              final cards = state.cards;
              if (cards.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                      'No card for this account. You can start creating one!',
                      style: appTitleStyle,
                      textAlign: TextAlign.center),
                );
              }
              return ListOfCardsThumbnails(
                  cards: cards, parentPath: '/home/my-card-details/');
            }
            if (state is MyCardsFailure) {
              return Text(state.error);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
