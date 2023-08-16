import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/bloc/card_details/card_details_bloc.dart';
import 'package:flutter_easy_card/core/utils/firebase_collection_method.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_easy_card/components/circle_icon.dart';
import 'package:flutter_easy_card/components/custom_action_button.dart';
import 'package:flutter_easy_card/theme.dart';
import 'package:go_router/go_router.dart';

class MyCardDetailsScreen extends StatefulWidget {
  const MyCardDetailsScreen(
      {super.key, required this.cardId, required this.myCardDetailsBloc});
  final String cardId;
  final CardDetailsBloc myCardDetailsBloc;

  @override
  State<MyCardDetailsScreen> createState() => _MyCardDetailsScreenState();
}

class _MyCardDetailsScreenState extends State<MyCardDetailsScreen> {
  @override
  void initState() {
    super.initState();
    widget.myCardDetailsBloc.add(FetchCardDetails(widget.cardId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      floatingActionButton: SizedBox(
        width: 120,
        child: CustomActionButton(
          onPressed: () {
            print('share');
          },
          icon: Icons.share,
          label: 'Share',
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: black,
              size: 32,
            ),
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              print('edit');
            },
            child: const Text('Edit', style: purpleTextButton),
          ),
        ],
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
          child: BlocBuilder<CardDetailsBloc, CardDetailsState>(
            bloc: widget.myCardDetailsBloc,
            builder: (context, state) {
              if (state is CardDetailsPending) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is CardDetailsFailure) {
                return const Center(
                  child: Text('Load failed'),
                );
              }

              if (state is CardDetailsSuccess) {
                final cardDetails = state.cardDetail;
                return Column(
                  children: [
                    Container(
                      height: 240,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(cardDetails.imageUrl != ""
                              ? cardDetails.imageUrl
                              : "https://dummyimage.com/600x600/000/fff"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Visibility(
                      visible: cardDetails.name != "",
                      child: Text(cardDetails.name,
                          style: titleH1TextStyle, textAlign: TextAlign.center),
                    ),
                    Visibility(
                      visible: cardDetails.jobTitle != "",
                      child: Text(cardDetails.jobTitle, style: appTitleStyle)),
                    Visibility(
                      visible: cardDetails.company != "",
                      child: Text(cardDetails.company, style: appTitleStyle)),
                    const SizedBox(height: 14),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: sidePadding),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: cardDetails.email != "",
                              child: Row(
                                children: [
                                  const CircleIcon(
                                    iconData: Icons.email,
                                    backgroundColor: easyPurple,
                                    iconColor: Colors.white,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    cardDetails.email,
                                    textAlign: TextAlign.left,
                                    style: contentStyle,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Visibility(
                              visible: cardDetails.phone != "",
                              child: Row(
                                children: [
                                  const CircleIcon(
                                    iconData: Icons.phone,
                                    backgroundColor: easyPurple,
                                    iconColor: Colors.white,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    cardDetails.phone,
                                    textAlign: TextAlign.left,
                                    style: contentStyle,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: cardDetails.website != "",
                          child: IconButton(
                            icon: FaIcon(FontAwesomeIcons.globe,
                                color: easyPurple, size: 30),
                            onPressed: () {
                              print('more');
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.linkedinIn,
                              color: easyPurple, size: 30),
                          onPressed: () {
                            print('more');
                          },
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.facebook,
                              color: easyPurple, size: 30),
                          onPressed: () {
                            print('more');
                          },
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.twitter,
                              color: easyPurple, size: 30),
                          onPressed: () {
                            print('more');
                          },
                        ),
                      ],
                    ),
                  ],
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}




//  padding: EdgeInsets.symmetric(horizontal: sidePadding),