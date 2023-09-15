import 'package:flutter/material.dart';
import 'package:flutter_easy_card/core/types/card_model_with_id.dart';
import 'package:flutter_easy_card/theme.dart';
import 'package:go_router/go_router.dart';

class ListOfCardsThumbnails extends StatelessWidget {
  const ListOfCardsThumbnails(
      {super.key, required this.cards, required this.parentPath});
  final List<CardModelWithId> cards;
  final String parentPath;

  @override
  Widget build(BuildContext context) {
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
            context.push('$parentPath${cards[index].id}');
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
}
