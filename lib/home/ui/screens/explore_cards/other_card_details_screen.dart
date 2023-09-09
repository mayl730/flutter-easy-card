import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/core/service/firebase_collection_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

import 'package:flutter_easy_card/bloc/card_details/card_details_bloc.dart';
import 'package:flutter_easy_card/bloc/save_card/save_card_bloc.dart';
import 'package:flutter_easy_card/components/custom_action_icon_button.dart';
import 'package:flutter_easy_card/core/adapter/user_store.dart';
import 'package:flutter_easy_card/components/circle_icon.dart';
import 'package:flutter_easy_card/components/custom_action_button.dart';
import 'package:flutter_easy_card/theme.dart';

class OtherCardDetailsScreen extends StatefulWidget {
  OtherCardDetailsScreen({
    super.key,
    required this.cardId,
    required this.cardDetailsBloc,
    required this.userStore,
    required this.firebaseCollectionService,
  }) : saveCardBloc = SaveCardBloc(
            userStore: userStore,
            firebaseCollectionService: firebaseCollectionService);
  final UserStore userStore;
  final FirebaseCollectionService firebaseCollectionService;
  final String cardId;
  final CardDetailsBloc cardDetailsBloc;
  final SaveCardBloc saveCardBloc;

  @override
  State<OtherCardDetailsScreen> createState() => _OtherCardDetailsScreenState();
}

class _OtherCardDetailsScreenState extends State<OtherCardDetailsScreen> {
  @override
  void initState() {
    super.initState();
    widget.cardDetailsBloc.add(FetchCardDetails(widget.cardId));
  }

  @override
  Widget build(BuildContext context) {
    String currentParentRoute =
        GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();

    return BlocBuilder<CardDetailsBloc, CardDetailsState>(
      bloc: widget.cardDetailsBloc,
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
          bool isSaved = state.isSaved;
          return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.white,
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 120,
                  child: CustomActionButton(
                    onPressed: () {
                      Share.share(
                          'Check out My name Card! https://example.com/${widget.cardId}}');
                    },
                    icon: Icons.share,
                    label: 'Share',
                    color: Color(int.parse(cardDetails.colorTheme)),
                  ),
                ),
                const SizedBox(width: 10),
                BlocBuilder<SaveCardBloc, SaveCardState>(
                  bloc: widget.saveCardBloc,
                  builder: (context, state) {
                    if (state is SaveCardSuccess) {
                      isSaved = state.isSaved;
                    }
                    return SizedBox(
                      width: 65,
                      child: CustomActionIconButton(
                        onPressed: () {
                          widget.saveCardBloc
                              .add(SaveCard(cardId: widget.cardId));
                        },
                        icon: isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: Color(int.parse(cardDetails.colorTheme)),
                      ),
                    );
                  },
                )
              ],
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
                    if (currentParentRoute.startsWith('/explore-cards')) {
                      debugPrint(currentParentRoute);
                      context.push("/explore-cards");
                    }
                    if (currentParentRoute.startsWith('/saved-cards')) {
                      debugPrint(currentParentRoute);
                      context.push("/saved-cards");
                    }
                  },
                ),
              ),
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Card Details',
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
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(cardDetails.imageUrl != ""
                            ? cardDetails.imageUrl
                            : "https://firebasestorage.googleapis.com/v0/b/flutter-easy-card.appspot.com/o/assets%2Fno_image2.jpg?alt=media&token=87f4b01f-7250-4346-b3c8-2dd2964a463e"),
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
                                CircleIcon(
                                  iconData: Icons.email,
                                  backgroundColor:
                                      Color(int.parse(cardDetails.colorTheme)),
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
                                CircleIcon(
                                  iconData: Icons.phone,
                                  backgroundColor:
                                      Color(int.parse(cardDetails.colorTheme)),
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
                              color: Color(int.parse(cardDetails.colorTheme)),
                              size: 30),
                          onPressed: () {
                            launchUrl(Uri.parse(cardDetails.website),
                                mode: LaunchMode.externalApplication);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Visibility(
                        visible: cardDetails.linkedin != "",
                        child: IconButton(
                          icon: FaIcon(FontAwesomeIcons.linkedinIn,
                              color: Color(int.parse(cardDetails.colorTheme)),
                              size: 30),
                          onPressed: () {
                            launchUrl(Uri.parse(cardDetails.linkedin),
                                mode: LaunchMode.externalApplication);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Visibility(
                        visible: cardDetails.facebook != "",
                        child: IconButton(
                          icon: FaIcon(FontAwesomeIcons.facebook,
                              color: Color(int.parse(cardDetails.colorTheme)),
                              size: 30),
                          onPressed: () {
                            launchUrl(Uri.parse(cardDetails.facebook),
                                mode: LaunchMode.externalApplication);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Visibility(
                        visible: cardDetails.twitter != "",
                        child: IconButton(
                          icon: FaIcon(FontAwesomeIcons.twitter,
                              color: Color(int.parse(cardDetails.colorTheme)),
                              size: 30),
                          onPressed: () {
                            launchUrl(Uri.parse(cardDetails.twitter),
                                mode: LaunchMode.externalApplication);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              )),
            ),
          );
        }
        return Container();
      },
    );
  }
}
