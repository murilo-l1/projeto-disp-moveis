import 'package:flutter/material.dart';
import 'package:expense_tracker/pages/esqueci_senha/components/body.dart';


class EsqueciSenha extends StatelessWidget {
  const EsqueciSenha({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true, // Adicione esta linha
          title: const Text(
            'Esqueci a senha',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: const Body(),
    );
  }
}