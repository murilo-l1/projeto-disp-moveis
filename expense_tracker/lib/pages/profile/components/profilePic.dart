import 'dart:io';
import 'package:expense_tracker/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:expense_tracker/services/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  File? _selectedImage;
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
      // handle the case where there is no logged in user
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
      // handle exception
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircleAvatar(
                backgroundImage: _selectedImage == null
                    ? const AssetImage("assets/images/profilePicture.jpg")
                        as ImageProvider<Object>
                    : FileImage(_selectedImage!),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color.fromARGB(255, 100, 205, 212)
                        .withOpacity(1.0),
                  ),
                  child: Align(
                    alignment: Alignment
                        .center, // Centraliza o ícone dentro do Container
                    child: IconButton(
                      icon: Icon(
                        LineAwesomeIcons.camera,
                        color:
                            const Color.fromARGB(255, 0, 0, 0).withOpacity(1.0),
                        size: 25.0,
                      ),
                      onPressed: () {
                        _pegarImagemGaleria();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          userName,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          userEmail,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Future _pegarImagemGaleria() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnImage == null) return;
    setState(() {
      _selectedImage = File(returnImage.path);
    });
  }
}
