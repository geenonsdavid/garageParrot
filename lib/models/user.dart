// Worker class
class User {
  final String id;
  final String name;
  final String lastname;
  final String email;
  final String phone;
  final String userpassword;

  User({
    required this.id,
    required this.name,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.userpassword,
  });

  Map<String, String> toMap() {
    return {
      'id': id,
      'name': name,
      'lastname': lastname,
      'email': email,
      'phone': phone,
      'userpassword': userpassword,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      name: json['name'],
      lastname: json['lastname'],
      email: json['email'],
      phone: json['phone'],
      userpassword: json['userpassword'] ?? '',
    );
  }
}
