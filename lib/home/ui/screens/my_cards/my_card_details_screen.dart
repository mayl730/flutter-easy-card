import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/bloc/card_details/card_details_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_easy_card/components/circle_icon.dart';
import 'package:flutter_easy_card/components/custom_action_button.dart';
import 'package:flutter_easy_card/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class MyCardDetailsScreen extends StatefulWidget {
  const MyCardDetailsScreen(
      {super.key, required this.cardId});
  final String cardId;

  @override
  State<MyCardDetailsScreen> createState() => _MyCardDetailsScreenState();
}

class _MyCardDetailsScreenState extends State<MyCardDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardDetailsBloc, CardDetailsState>(
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
          return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.white,
            floatingActionButton: SizedBox(
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
                    context.push("/home");
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    context.push('/home/edit-card/${widget.cardId}');
                  },
                  child: Text('Edit', style: customTextButton()),
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
                  child: Column(
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




//  padding: EdgeInsets.symmetric(horizontal: sidePadding),