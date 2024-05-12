class User {
  final int? id;
  String name;
  final String email;
  final String password;

  User({
    required this.email,
    required this.password,
    this.id,
    this.name = 'murilo',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
      };
}
