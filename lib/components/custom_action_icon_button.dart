import 'package:flutter/material.dart';
import 'package:flutter_easy_card/theme.dart';

class CustomActionIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? color;

  const CustomActionIconButton({
    super.key,
    required this.onPressed,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.all(16.0),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color?>(
            color ?? easyPurple,
          ),
          elevation: MaterialStateProperty.all<double>(0),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24.0,
        ),
      ),
    );
  }
}
