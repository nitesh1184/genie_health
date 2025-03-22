class User {
  final String name;
  final String role;
  final String email;

  User({required this.name, required this.role, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      role: json['role'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'name': name,
      'email': email,
    };
  }
}