import 'package:expense_tracker/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              isDarkMode ? LineAwesomeIcons.motorcycle : LineAwesomeIcons.moon,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(40.0), // Adjust padding as needed
          child: Column(
            children: [
              SizedBox(
                width: 120.0,
                height: 120.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.asset(
                    'projeto-disp-moveis/expense_tracker/assets/icons/amostra.svg',
                    fit: BoxFit.cover, // Ensure image fills the container
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Murilo",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                "murilo@gmail.com",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 45,
                width: 180,
                child: ElevatedButton(
                  onPressed: () {}, // Add functionality to edit profile
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.greenAccent, // Adjust color preference
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.amber.withOpacity(0.1),
                  ),
                  child: Icon(
                    LineAwesomeIcons.cog,
                    color: Colors.amberAccent,
                  ),
                ),
                title: Text('Settings',
                    style: Theme.of(context).textTheme.bodySmall),
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.amber.withOpacity(0.1),
                  ),
                  child: Icon(
                    LineAwesomeIcons.cog,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
