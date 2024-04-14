import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class profilePicture extends StatelessWidget {
  const profilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(
                "assets/images/profilePicture.jpg"), //adicionar profile picture
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Color.fromARGB(255, 67, 201, 210).withOpacity(1.0),
              ),
              child: Icon(
                LineAwesomeIcons.camera, //icone da foto de perfil
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(1.0),
                size: 25.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
