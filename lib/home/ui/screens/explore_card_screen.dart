import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/bloc/my_cards/my_cards_bloc.dart';
import 'package:flutter_easy_card/theme.dart';
import 'package:go_router/go_router.dart';

class ExploreCardScreen extends StatefulWidget {
  const ExploreCardScreen({super.key, required this.allCardsBloc});
  final MyCardsBloc allCardsBloc;

  @override
  State<ExploreCardScreen> createState() => _ExploreCardScreenState();
}

class _ExploreCardScreenState extends State<ExploreCardScreen> {
  @override
  void initState() {
    super.initState();
    widget.allCardsBloc.add(FetchMyCards());
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
          child: Icon(Icons.home_filled, size: 32, color: easyPurple),
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
              // onPressed: () => {context.go("/home")},
              onPressed: () => {},
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
          bloc: widget.allCardsBloc,
          builder: (context, state) {
            if (state is MyCardsPending) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MyCardsSuccess) {
              final cards = state.cards;
              if (cards.isEmpty) {
                return const Text(
                    'No card for this account. You can start creating one!');
              }
              return GridView.builder(
                padding: const EdgeInsets.all(20),
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
                      print(cards[index].id);
                      context.push('/home/my-card-details/${cards[index].id}');
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
                                        : "https://dummyimage.com/600x600/000/fff",
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
            if (state is MyCardsFailure) {
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