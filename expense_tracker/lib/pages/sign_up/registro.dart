import 'package:expense_tracker/pages/sign_up/components/body.dart';
import 'package:flutter/material.dart';

class RegistroPage extends StatelessWidget {
  const RegistroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Registrar',
          style: TextStyle(
              color: Color.fromARGB(255, 159, 151, 151), fontSize: 20),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Body(),
    );
  }
}
