import 'package:expense_tracker/models/enums.dart';
import 'package:expense_tracker/pages/profile/components/body.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/pages/profile/components/customBottomBar.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = '/profile';

  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: const Body(),
      bottomNavigationBar: const customBottomBarNav(
        selectedMenu: MenuState.profile,
      ),
    );
  }
}

