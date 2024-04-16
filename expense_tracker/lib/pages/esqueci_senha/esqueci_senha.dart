import 'package:flutter/material.dart';
import 'package:expense_tracker/pages/esqueci_senha/components/body.dart';


class EsqueciSenha extends StatelessWidget {
  const EsqueciSenha({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true, // Adicione esta linha
          title: Text(
            'Esqueci a senha',
            style: TextStyle(color: const Color.fromARGB(255, 159, 151, 151), fontSize: 20),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Body(),
    );
  }
}