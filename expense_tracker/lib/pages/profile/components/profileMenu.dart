import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    required this.text,
    required this.icon,
    required this.press,
    super.key,
  });

  final String text;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Color.fromARGB(255, 227, 228, 228),
        ),
        onPressed: press, //escolhe a função ao clicar aqui
        child: Row(
          children: [
            Icon(
              icon, //escolhe o icone com o LineAwesomeIcons aqui
              size: 35,
              color: Color.fromARGB(255, 0, 188, 201),
            ),
            SizedBox(width: 20),
            Expanded(
                child: Text(
              text, //escolhe o texto aqui
              style: Theme.of(context).textTheme.bodyMedium,
            )),
            Icon(LineAwesomeIcons.angle_right, size: 35, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
