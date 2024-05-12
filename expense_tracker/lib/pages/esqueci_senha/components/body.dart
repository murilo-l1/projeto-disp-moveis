import 'package:expense_tracker/pages/login/login.dart';
import 'package:expense_tracker/pages/sign_up/registro.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        // Wrap entire content to allow scrolling
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20.0), // Adjusted padding
          child: Column(
            children: [
              const SizedBox(height: 60.0), // Consistent spacing
              const Text(
                'Esqueci a Senha',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Porfavor digite seu email e enviaremos \num link para você redefinir sua senha.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60.0),
              const EsqueciSenhaEnvio(),
              const SizedBox(height: 40.0), // Reduced bottom padding
              buttonLogin(context),
              const SizedBox(height: 20.0), // Reduced bottom padding
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Não tem uma conta?",
                    style: TextStyle(
                      fontSize: 15.0,
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
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 0, 188, 201),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EsqueciSenhaEnvio extends StatefulWidget {
  const EsqueciSenhaEnvio({super.key});

  @override
  State<EsqueciSenhaEnvio> createState() => _EsqueciSenhaEnvioState();
}

class _EsqueciSenhaEnvioState extends State<EsqueciSenhaEnvio> {
  get errors => null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            errors.add("Por favor, digite seu email");
          }
          return null;
        },
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
          'Enviar',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255), fontSize: 18),
        ),
      ),
    ),
  );
}
