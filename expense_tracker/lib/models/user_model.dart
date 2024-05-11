class User {
  final int? id;
  final String name;
  final String email;
  final String password;

  User(
      {required this.name,
      required this.email,
      required this.password,
      this.id});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
      };
}
