import 'package:flutter/material.dart';
import 'package:flutter_easy_card/components/circle_icon.dart';
import 'package:flutter_easy_card/core/types/card_model_with_id.dart';
import 'package:flutter_easy_card/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CardDetails extends StatelessWidget {
  const CardDetails({super.key, required this.cardDetails});
  final CardModelWithId cardDetails;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                    height: 260,
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
                        style: titleH2TextStyle, textAlign: TextAlign.center),
                  ),
                  Visibility(
                      visible: cardDetails.jobTitle != "",
                      child: Text(cardDetails.jobTitle, style: appTitleStyle)),
                  Visibility(
                      visible: cardDetails.company != "",
                      child: Text(cardDetails.company, style: appTitleStyle)),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: sidePadding),
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
            );
  }
}