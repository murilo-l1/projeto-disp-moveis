import 'package:expense_tracker/pages/home.dart';
import 'package:expense_tracker/pages/login/components/body.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true, // Adicione esta linha
          title: Text(
            'Login',
            style: TextStyle(color: const Color.fromARGB(255, 159, 151, 151), fontSize: 20),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
      ),
      body: const Body(),
    );
  }
}

