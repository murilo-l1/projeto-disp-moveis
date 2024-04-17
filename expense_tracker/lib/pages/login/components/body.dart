import 'package:expense_tracker/pages/registro/registro.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:expense_tracker/pages/home.dart';
import 'package:expense_tracker/pages/login/components/log.dart'; 
import 'botoes_social.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView( // Wrap potentially overflowing content
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
                    "Entre com o seu email e senha \nou continue com sua rede social",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  const LoginForm(),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BotoesSocial(
                        icon: LineAwesomeIcons.google_logo,
                        color: Colors.black,
                        size: 30,
                        press: () {},
                      ),
                      BotoesSocial(
                        icon: LineAwesomeIcons.facebook_f,
                        color: Colors.black,
                        size: 30,
                        press: () {},
                      ),
                    ],
                  ),
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
                      )
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



Padding buttonLogin(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
    child: SizedBox(
      width: 500,
      height: 60,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 188, 201),
        ),
        onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                ),
        child: const Text(
          'Continuar',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 18),
          
        ),
      ),
    ),
  );
}