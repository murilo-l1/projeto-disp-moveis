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
            SizedBox(height: 50,),
            Text(
              'Criar Conta', 
              style: TextStyle(fontSize: 30,
              fontWeight: FontWeight.bold,),
            ),
            Text(
                  "Complete os espaços \nou continue com sua rede social",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30,),
          insertEmail(),
          SizedBox(height: 20,),
          insertPassword(),
          SizedBox(height: 20,),
          insertPasswordAgain(),
          SizedBox(height: 30,),
          buttonLogin(context),
          SizedBox(height: 30,),
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
            contentPadding: EdgeInsets.symmetric(
              horizontal: 45,
              vertical: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Colors.blue),
              gapPadding: 10,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 20),
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
            contentPadding: EdgeInsets.symmetric(
              horizontal: 45,
              vertical: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Colors.blue),
              gapPadding: 10,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 20),
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
            contentPadding: EdgeInsets.symmetric(
              horizontal: 45,
              vertical: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Colors.blue),
              gapPadding: 10,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 20),
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
    child: Container(
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
                    builder: (context) => LoginPage(),
                  ),
                ),
        child: Text(
          'Continuar',
          textAlign: TextAlign.center,
          style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255), fontSize: 18),
          
        ),
      ),
    ),
  );
}