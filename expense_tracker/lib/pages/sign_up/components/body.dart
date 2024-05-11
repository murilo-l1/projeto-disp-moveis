import 'package:expense_tracker/models/user_model.dart';
import 'package:expense_tracker/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:expense_tracker/pages/login/components/botoes_social.dart';
import 'package:expense_tracker/pages/login/login.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  // Define TextEditingController instances
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Criar Conta',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Complete os espaços \nou continue com sua rede social",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              insertEmail(),
              const SizedBox(
                height: 20,
              ),
              insertPassword(),
              const SizedBox(
                height: 20,
              ),
              insertPasswordAgain(),
              const SizedBox(
                height: 30,
              ),
              buttonLogin(context, formKey, validateEmail, validatePassword),
              const SizedBox(
                height: 30,
              ),
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
      ),
    );
  }

  TextFormField insertPasswordAgain() {
    return TextFormField(
      controller: confirmPasswordController,
      obscureText: true,
      validator: validatePasswordAgain,
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
          child: Icon(
            LineAwesomeIcons.lock,
            size: 30,
          ),
        ),
      ),
    );
  }

  TextFormField insertPassword() {
    return TextFormField(
      controller: passwordController,
      validator: validatePassword,
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
          child: Icon(
            LineAwesomeIcons.lock,
            size: 30,
          ),
        ),
      ),
    );
  }

  TextFormField insertEmail() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
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
          child: Icon(
            LineAwesomeIcons.envelope,
            size: 30,
          ),
        ),
      ),
    );
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "email é necessário";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "senha é necessária";
    }
    return null;
  }

  String? validatePasswordAgain(String? value) {
    if (value!.isEmpty) {
      return "senha é necessária";
    } else if (passwordController.text != confirmPasswordController.text) {
      return "senhas não coincidem";
    }
    return null;
  }

  Padding buttonLogin(
      BuildContext context,
      GlobalKey<FormState> formKey,
      String? Function(String?) validateEmail,
      String? Function(String?) validatePassword) {
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
          onPressed: () {
            if (formKey.currentState!.validate()) {
              //login method

              final db = DatabaseHelper();
              db
                  .signup(User(
                      email: emailController.text,
                      password: passwordController.text))
                  .whenComplete(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              });
            }
          },
          child: const Text(
            'Continuar',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255), fontSize: 18),
          ),
        ),
      ),
    );
  }
}
