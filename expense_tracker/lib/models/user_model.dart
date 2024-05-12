class User {
  final int? id;
  String name;
  final String email;
  final String password;

  User({
    required this.email,
    required this.password,
    this.id,
  }) : name = getEmailFirstWord(email);

  factory User.fromJson(Map<String, dynamic> json) {
    String email = json['email'];
    // Extrair a primeira palavra do email
    //String name = getEmailFirstWord(email);

    return User(
      id: json['id'],
      email: email,
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
      };

  static String getEmailFirstWord(String email) {
    // Separar o email por '@'
    List<String> parts = email.split('@');
    // Extrair a primeira parte, que é o nome de usuário
    String username = parts.isNotEmpty ? parts[0] : '';
    return username;
  }
}
