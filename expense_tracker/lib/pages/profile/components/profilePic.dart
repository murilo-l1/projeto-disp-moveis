import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(  
      children: [
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/images/profilePicture.jpg"),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color.fromARGB(255, 100, 205, 212).withOpacity(1.0),
                  ),
                  child: Icon(
                    LineAwesomeIcons.camera,
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(1.0),
                    size: 25.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Murilo",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          "murilo@gmail.com",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
