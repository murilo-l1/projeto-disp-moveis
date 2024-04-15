import 'package:expense_tracker/models/enums.dart';
import 'package:expense_tracker/pages/historical.dart';
import 'package:expense_tracker/pages/home.dart';
import 'package:expense_tracker/pages/profile/components/body.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:expense_tracker/pages/profile/components/customBottomBar.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = '/profile';

  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Body(),
      bottomNavigationBar: const customBottomBarNav(
        selectedMenu: MenuState.profile,
      ),
    );
  }
}

