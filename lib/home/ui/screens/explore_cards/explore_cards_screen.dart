import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/bloc/explore_cards/explore_cards_bloc.dart';
import 'package:flutter_easy_card/components/list_of_cards_thumbnails.dart';
import 'package:flutter_easy_card/theme.dart';
import 'package:go_router/go_router.dart';

class ExploreCardsScreen extends StatefulWidget {
  const ExploreCardsScreen({super.key, required this.exploreCardsBloc});
  final ExploreCardsBloc exploreCardsBloc;

  @override
  State<ExploreCardsScreen> createState() => _ExploreCardsScreenState();
}

class _ExploreCardsScreenState extends State<ExploreCardsScreen> {
  @override
  void initState() {
    super.initState();
    widget.exploreCardsBloc.add(FetchAllCards());
  }

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
          child: Icon(Icons.person_search_rounded, size: 32, color: easyPurple),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Explore Cards',
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
                    color: inActiveGray,
                    size: 24,
                  ),
                  Text(
                    'Home',
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
              onPressed: () => {},
              icon: const Column(
                children: [
                  SizedBox(height: 5),
                  Icon(
                    Icons.person_search_rounded,
                    color: easyPurple,
                    size: 24,
                  ),
                  Text(
                    'Explore',
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
        child: BlocBuilder<ExploreCardsBloc, ExploreCardsState>(
          bloc: widget.exploreCardsBloc,
          builder: (context, state) {
            if (state is ExploreCardsPending) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ExploreCardsSuccess) {
              final cards = state.cards;
              if (cards.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('No cards found. Please try again later.',
                      style: appTitleStyle, textAlign: TextAlign.center),
                );
              }
              return ListOfCardsThumbnails(
                  cards: cards,
                  parentPath: '/explore-cards/other-card-details/');
            }
            if (state is ExploreCardsFailure) {
              return const Text("Error!");
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

// AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: const Padding(
//           padding: EdgeInsets.only(left: sidePadding),
//           child: Icon(Icons.person_search_rounded, size: 32, color: easyPurple),
//         ),
//         title: const Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text(
//               'Explore',
//               style: appTitleStyle,
//               textAlign: TextAlign.start,
//             ),
//           ],
//         ),
//       ),
