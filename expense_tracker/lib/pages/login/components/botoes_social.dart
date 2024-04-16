import 'package:flutter/material.dart';

class BotoesSocial extends StatelessWidget {
  const BotoesSocial({
    super.key,
    required this.icon,
    required this.press,
    this.color = Colors.black,
    this.size = 24.0,
  });

  final IconData icon;
  final VoidCallback press;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(0),
        height: 35,
        width: 35,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 219, 215, 215), 
          shape: BoxShape.circle
        ),
        child: Icon(icon, color: color, size: size),
      ),
    );
  }
}