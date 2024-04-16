import 'package:expense_tracker/pages/login/components/body.dart';
import 'package:expense_tracker/pages/login/login.dart';
import 'package:expense_tracker/pages/registro/registro.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:expense_tracker/pages/login/components/log_error.dart';

class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 60,),
          Text(
            'Esqueci a Senha', 
            style: TextStyle(fontSize: 30,
            fontWeight: FontWeight.bold,),
          ),
          Text(
            "Porfavor digite seu email e enviaremos \num link para você redefinir sua senha.",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 60,),
          EsqueciSenhaEnvio(),
          SizedBox(height: 70,),
          buttonLogin(context),
          SizedBox(height: 200,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Não tem uma conta?", 
                      style: TextStyle(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 159, 151, 151),
                      ),
                    ),
                    GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegistroPage(), // Substitua por sua página de registro
      ),
    );
  },
  child: Text(
    " Registre-se.", 
    style: TextStyle(
      fontSize: 15,
      color: const Color.fromARGB(255, 0, 188, 201),
    ),
  ),
)
                  ],
                )
        ],
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
              if(value == null || value.isEmpty) {
              errors.add("Por favor, digite seu email");
              }
              return null;
            },
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
          'Enviar',
          textAlign: TextAlign.center,
          style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255), fontSize: 18),
          
        ),
      ),
    ),
  );
}