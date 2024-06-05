import 'package:expense_tracker/pages/login/login.dart';
import 'package:expense_tracker/pages/profile/Profile.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profileMenu.dart';
import 'profilePic.dart';
import 'package:expense_tracker/models/user_model.dart';
import 'package:expense_tracker/services/database_helper.dart';

class Body extends StatefulWidget {
  const Body({super.key});
  

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String userName = 'Loading...';
  String userEmail = 'Loading...';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchUserDetails();
  }

  Future<String> getLoggedInUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('loggedInUserEmail');
    if (email == null) {
      throw Exception('No user is logged in');
    }
    return email;
  }

  Future<void> fetchUserDetails() async {
    try {
      List<User>? users = await DatabaseHelper.getUsers();
      if (users != null && users.isNotEmpty) {
        String loggedInEmail = await getLoggedInUserEmail(); // pega o email
        for (User user in users) {
          if (user.email == loggedInEmail) {
            setState(() {
              userName = user.name;
              userEmail = user.email;
            });
            break;
          }
        }
      }
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 45,
          ),
          const ProfilePicture(),
          const SizedBox(
            height: 45,
          ),
          ProfileMenu(
            icon: LineAwesomeIcons.envelope,
            text: 'Alterar e-mail',
            press: () {
              openEditEmailBox(context, getLoggedInUserEmail);
            },
            backgroundColor: Colors.blue[100],
            backgroundOpacity: 0.2,
          ),
          ProfileMenu(
            icon: LineAwesomeIcons.lock,
            text: 'Alterar senha',
            press: () => openEditPasswordBox(context, getLoggedInUserEmail),
            backgroundColor: Colors.blue[100],
            backgroundOpacity: 0.2,
          ),
          ProfileMenu(
            icon: LineAwesomeIcons.door_open,
            text: 'Sair',
            press: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            ),
            textColor: Colors.red,
            backgroundColor: Colors.red[100],
            backgroundOpacity: 0.5,
          ),
        ],
      ),
    );
  }
}



void openEditEmailBox(BuildContext context, Future<String> Function() getLoggedInUserEmail) async {
  TextEditingController currentEmailController = TextEditingController();
  TextEditingController newEmailController = TextEditingController();

  // Obtenha o email do usuário logado
  String loggedInEmail = await getLoggedInUserEmail();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Editar Email'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: currentEmailController,
            decoration: const InputDecoration(
              labelText: 'Email Atual',
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: newEmailController,
            decoration: const InputDecoration(
              labelText: 'Novo Email',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () async {
            // Obtenha o valor final do campo de texto
            String currentEmail = currentEmailController.text;
            String newEmail = newEmailController.text;
            if (currentEmail == loggedInEmail) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('loggedInUserEmail', newEmail);

              await DatabaseHelper.updateUserEmail(loggedInEmail, newEmail);
              Navigator.pop(context);

              // Navegue para a tela de perfil
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('O email atual fornecido está incorreto.')),
              );
            }
          },
          child: const Text('Salvar'),
        ),
      ],
    ),
  );
}

void openEditPasswordBox(BuildContext context, Future<String> Function() getLoggedInUserEmail) async {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  String loggedInEmail = await getLoggedInUserEmail();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Editar Senha'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: currentPasswordController,
            obscureText: true, //para esconder
            decoration: const InputDecoration(
              labelText: 'Senha Atual',
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: newPasswordController,
            obscureText: true, //para esconder
            decoration: const InputDecoration(
              labelText: 'Nova Senha',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () async {
            String currentPassword = currentPasswordController.text;
            String newPassword = newPasswordController.text;
            String? storedPassword = await DatabaseHelper.getUserPassword(loggedInEmail);

            if (currentPassword == storedPassword) {
              await DatabaseHelper.updateUserPassword(loggedInEmail, newPassword);
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('A senha atual fornecida está incorreta.')),
              );
            }
          },
          child: const Text('Salvar'),
        ),
      ],
    ),
  );
}