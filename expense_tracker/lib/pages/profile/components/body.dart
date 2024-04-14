import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'profileMenu.dart';
import 'profilePic.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        profilePicture(),
        SizedBox(height: 20),
        ProfileMenu(
          icon: LineAwesomeIcons.user,
          text: 'oi',
          press: () {},
        ),
        ProfileMenu(
          icon: LineAwesomeIcons.user,
          text: 'Logout',
          press: () {},
        ),
      ],
    );
  }
}
