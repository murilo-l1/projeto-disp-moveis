import 'package:expense_tracker/pages/sign_up/registro.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/pages/login/components/log.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Bem-vindo de volta",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Entre com o seu email e senha \n",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  const LoginForm(),
                  const SizedBox(height: 50),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Não tem uma conta?",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 159, 151, 151),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegistroPage(),
                            ),
                          );
                        },
                        child: const Text(
                          " Registre-se.",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 0, 188, 201),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
