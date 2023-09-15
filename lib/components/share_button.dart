import 'package:flutter/material.dart';
import 'package:flutter_easy_card/components/custom_action_button.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({super.key, required this.colorCode, required this.cardId});
  final String colorCode;
  final String cardId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: CustomActionButton(
        onPressed: () {
          Share.share('Check out My name Card! https://example.com/$cardId');
        },
        icon: Icons.share,
        label: 'Share',
        color: Color(int.parse(colorCode)),
      ),
    );
  }
}
