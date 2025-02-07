
// Worker class
class Worker {
  final String id;
  final String name;
  final String lastname;
  final String email;
  final String phone;

  Worker({required this.id, required this.name, required this.lastname, required this.email, required this.phone});

  // Factory method to create a Worker instance from a JSON object
  factory Worker.fromJson(Map<String, dynamic> json) {
    return Worker(
      id: json['id'].toString(),
      name: json['name']?? '',
      lastname: json['lastname']?? '',
      email: json['email']?? '',
      phone: json['phone']?? '',
    );
  }
}
