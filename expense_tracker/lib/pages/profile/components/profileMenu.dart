import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    required this.text,
    required this.icon,
    required this.press,
    this.textColor,
    this.backgroundColor,
    this.backgroundOpacity,
    super.key,
  });

  final String text;
  final IconData icon;
  final VoidCallback press;
  final Color? textColor;
  final Color? backgroundColor;
  final double? backgroundOpacity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: backgroundColor?.withOpacity(backgroundOpacity ?? 1.0),
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(
              icon,
              size: 35,
              color: const Color.fromARGB(255, 0, 188, 201),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: textColor ?? Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
            ),
            const Icon(LineAwesomeIcons.angle_right, size: 35, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
