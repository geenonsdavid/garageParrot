// Worker class
class Worker {
  final String id;
  final String name;
  final String lastname;
  final String email;
  final String phone;
  final String userpassword;

  Worker({
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

  factory Worker.fromJson(Map<String, dynamic> json) {
    return Worker(
      id: json['id'].toString(),
      name: json['name'],
      lastname: json['lastname'],
      email: json['email'],
      phone: json['phone'],
      userpassword: json['userpassword'] ?? '',
    );
  }
}
