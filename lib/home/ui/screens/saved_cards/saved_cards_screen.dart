import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/bloc/explore_cards/explore_cards_bloc.dart';
import 'package:flutter_easy_card/bloc/load_saved_cards/load_saved_cards_bloc.dart';
import 'package:flutter_easy_card/theme.dart';
import 'package:go_router/go_router.dart';

class SavedCardsScreen extends StatefulWidget {
  const SavedCardsScreen({super.key, required this.savedCardsBloc});
  final LoadSavedCardsBloc savedCardsBloc;

  @override
  State<SavedCardsScreen> createState() => _SavedCardsScreenState();
}

class _SavedCardsScreenState extends State<SavedCardsScreen> {
  @override
  void initState() {
    super.initState();
    widget.savedCardsBloc.add(FetchSavedCards());
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
          child: Icon(Icons.bookmark, size: 32, color: easyPurple),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Saved Cards',
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
              onPressed: () => {},
              icon: const Column(
                children: [
                  SizedBox(height: 5),
                  Icon(
                    Icons.bookmark,
                    color: easyPurple,
                    size: 24,
                  ),
                  Text(
                    'Saved',
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
        child: BlocBuilder<LoadSavedCardsBloc, LoadSavedCardsState>(
          bloc: widget.savedCardsBloc,
          builder: (context, state) {
            if (state is LoadSavedCardsPending) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is LoadSavedCardsSuccess) {
              final cards = state.cards;
              if (cards.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                      'No saved card. Explore cards and save them to view them here!',
                      style: appTitleStyle,
                      textAlign: TextAlign.center),
                );
              }
              return GridView.builder(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
                itemCount: cards.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 22,
                  mainAxisSpacing: 22,
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context.push(
                          '/explore-cards/other-card-details/${cards[index].id}');
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
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    cards[index].imageUrl.isNotEmpty
                                        ? cards[index].imageUrl
                                        : "https://firebasestorage.googleapis.com/v0/b/flutter-easy-card.appspot.com/o/assets%2Fno_image2.jpg?alt=media&token=87f4b01f-7250-4346-b3c8-2dd2964a463e",
                                  )),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                              child: Text(cards[index].name,
                                  style: thumbnailCardTitleStyle)),
                        ],
                      ),
                    ),
                  );
                },
              );
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