class User {
  final int? id;
  String name;
  String email;
  String password;

  User({
    required this.email,
    required this.password,
    this.id,
  }): this.name = email.split('@')[0];

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
  
  void setName(String newName) {
    this.name = newName;
  }
}

