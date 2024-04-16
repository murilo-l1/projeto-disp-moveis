import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:expense_tracker/pages/login/components/botoes_social.dart';
import 'package:expense_tracker/pages/login/login.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView( 
        child: Column(
          children: [
            const SizedBox(height: 50,),
            const Text(
              'Criar Conta', 
              style: TextStyle(fontSize: 30,
              fontWeight: FontWeight.bold,),
            ),
            const Text(
                  "Complete os espaços \nou continue com sua rede social",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30,),
          insertEmail(),
          const SizedBox(height: 20,),
          insertPassword(),
          const SizedBox(height: 20,),
          insertPasswordAgain(),
          const SizedBox(height: 30,),
          buttonLogin(context),
          const SizedBox(height: 30,),
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
          ],
        ),
      ),
    );
  }

  TextFormField insertPasswordAgain() {
    return TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Confirmar Senha",
            hintText: "Digite sua senha novamente.",
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 45,
              vertical: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: const BorderSide(color: Colors.blue),
              gapPadding: 10,
            ),
            suffixIcon: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(LineAwesomeIcons.lock, size: 30,
              ),
            ),
          ),
        );
  }

  TextFormField insertPassword() {
    return TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Senha",
            hintText: "Digite sua senha.",
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 45,
              vertical: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: const BorderSide(color: Colors.blue),
              gapPadding: 10,
            ),
            suffixIcon: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(LineAwesomeIcons.lock, size: 30,
              ),
            ),
          ),
        );
  }

  TextFormField insertEmail() {
    return TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: "Email",
            hintText: "Digite seu email.",
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 45,
              vertical: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: const BorderSide(color: Colors.blue),
              gapPadding: 10,
            ),
            suffixIcon: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(LineAwesomeIcons.envelope, size: 30,
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
                    builder: (context) => const LoginPage(),
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