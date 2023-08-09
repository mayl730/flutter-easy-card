import 'package:flutter/material.dart';
import 'package:flutter_easy_card/theme.dart';

class CircleIcon extends StatelessWidget {
  final IconData iconData;
  final double size;
  final Color backgroundColor;
  final Color iconColor;

  const CircleIcon(
      {super.key,
      required this.iconData,
      this.size = 48,
      this.backgroundColor = easyPurple,
      this.iconColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: Center(
        child: Icon(
          iconData,
          color: iconColor,
          size: size * 0.5,
        ),
      ),
    );
  }
}
