import 'package:expense_tracker/pages/historical.dart';
import 'package:expense_tracker/pages/home.dart';
import 'package:expense_tracker/pages/profile/Profile.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:expense_tracker/models/enums.dart';

class customBottomBarNav extends StatelessWidget {
  const customBottomBarNav({
    required this.selectedMenu,
    super.key,
  });

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    const Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, -15),
              blurRadius: 20,
              color: const Color(0xFFDADADA).withOpacity(0.15)),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                LineAwesomeIcons.pie_chart,
                size: 30,
                color: MenuState.pie_chart == selectedMenu
                    ? Colors.blue
                    : inActiveIconColor,
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                LineAwesomeIcons.bar_chart,
                size: 30,
                color: MenuState.bar_chart == selectedMenu
                    ? Colors.blue
                    : inActiveIconColor,
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoricalPage(),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                LineAwesomeIcons.user,
                size: 30,
                color: MenuState.profile == selectedMenu
                    ? Colors.blue
                    : inActiveIconColor,
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
