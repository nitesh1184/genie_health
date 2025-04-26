class UserHandler {
  final String name;
  final String role;
  final String email;

  UserHandler({required this.name, required this.role, required this.email});

  factory UserHandler.fromJson(Map<String, dynamic> json) {
    return UserHandler(
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