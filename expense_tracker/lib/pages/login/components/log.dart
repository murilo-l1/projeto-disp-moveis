import 'package:expense_tracker/models/user_model.dart';
import 'package:expense_tracker/pages/esqueci_senha/esqueci_senha.dart';
import 'package:expense_tracker/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:expense_tracker/pages/login/components/log_error.dart';
import 'package:expense_tracker/pages/chart_screens/home.dart';
import 'package:collection/collection.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  bool remember = false;

  bool isLoginTrue = false;

  final db = DatabaseHelper();

  final email = TextEditingController();
  final password = TextEditingController();

  Login() async {
  final List<String> errors = [];

  // Validação dos campos de e-mail e senha
  if (formKey.currentState!.validate()) {
    // Imprime o e-mail e a senha inseridos
    print('Tentativa de login - E-mail: ${email.text}, Senha: ${password.text}');
    
    // Verifica todos os usuários no banco de dados
    final List<User>? users = await DatabaseHelper.getUsers();
    if (users != null) {
      // Procura pelo usuário com o e-mail fornecido
      final User? user = users.firstWhereOrNull((user) => user.email == email.text);
      if (user != null && user.password == password.text) {
        // Login bem-sucedido
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        // E-mail ou senha incorretos
        setState(() {
          isLoginTrue = true;
        });
      }
    } else {
      // Nenhum usuário encontrado
      setState(() {
        errors.add("Nenhum usuário encontrado");
      });
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          insertEmail(),
          const SizedBox(
            height: 25,
          ),
          insertPassword(),
          const SizedBox(
            height: 20,
          ),
          Error(errors: errors),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: const Color.fromARGB(255, 0, 188, 201),
                onChanged: (Value) {
                  setState(() {
                    remember = Value!;
                  });
                },
              ),
              const Text("Manter login"),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const EsqueciSenha(), // Substitua por sua página de esqueceu a senha
                    ),
                  );
                },
                child: const Text(
                  "Esqueceu a senha?",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
          isLoginTrue
              ? const Text(
                  "Email ou senha incorretos",
                  style: TextStyle(color: Colors.red),
                )
              : const SizedBox(),
          buttonLogin(context, formKey, validateEmail, validatePassword, Login),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  TextFormField insertPassword() {
  return TextFormField(
    controller: password, // Adicione o controlador de texto aqui
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
    controller: email, // Adicione o controlador de texto aqui
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
}

Padding buttonLogin(
    BuildContext context,
    GlobalKey<FormState> formKey,
    String? Function(String?) validateEmail,
    String? Function(String?) validatePassword,
    Function Login) {
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
            // Executando a função de login diretamente
            Login();
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
