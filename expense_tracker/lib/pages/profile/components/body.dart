import 'package:expense_tracker/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'profileMenu.dart';
import 'profilePic.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 45,),
        const ProfilePicture(),
        ProfileMenu(
          icon: LineAwesomeIcons.user,
          text: 'Editar nome',
          press: () => openEditNameBox(context),
          backgroundColor: Colors.blue[100],
          backgroundOpacity: 0.20,
        ),
        ProfileMenu(
          icon: LineAwesomeIcons.envelope,
          text: 'Alterar e-mail',
          press: () => openEditEmailBox(context),
          backgroundColor: Colors.blue[100],
          backgroundOpacity: 0.2,
        ),
        ProfileMenu(
          icon: LineAwesomeIcons.lock,
          text: 'Alterar senha',
          press: () => openEditPasswordBox(context),
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
    );
  }
}

void openEditNameBox(BuildContext context) {
  String newName = '';

  TextEditingController nameController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Editar Nome'), 
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController, 
            decoration: const InputDecoration(
              labelText: 'Nome', 
            ),
            onChanged: (value) {
              newName = value;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.black54), 
          ),
        ),
        ElevatedButton(
          onPressed: () {
            print('New name: $newName'); 
            Navigator.of(context).pop(); 
          },
          child: const Text('Salvar'), 
        ),
      ],
    ),
  );
}

void openEditEmailBox(BuildContext context) {
  String currentEmail = '';
  String newEmail = '';

  TextEditingController currentEmailController = TextEditingController();
  TextEditingController newEmailController = TextEditingController();

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
            onChanged: (value) {
              currentEmail = value;
            },
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: newEmailController,
            decoration: const InputDecoration(
              labelText: 'Novo Email',
            ),
            onChanged: (value) {
              newEmail = value;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); 
          },
          child: const Text('Salvar'),
        ),
      ],
    ),
  );
}

void openEditPasswordBox(BuildContext context) {
  String currentPassword = '';
  String newPassword = '';

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

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
            onChanged: (value) {
              currentPassword = value;
            },
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: newPasswordController,
            obscureText: true, //para esconder
            decoration: const InputDecoration(
              labelText: 'Nova Senha',
            ),
            onChanged: (value) {
              newPassword = value;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Salvar'),
        ),
      ],
    ),
  );
}
