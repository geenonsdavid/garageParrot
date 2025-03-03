import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:garage_parrot/src/utils/dialog_helpers.dart';
import 'package:garage_parrot/models/user.dart';
import 'package:garage_parrot/themes/colors.dart';
import 'package:garage_parrot/services/api_service.dart';
import 'package:http/http.dart' as http;

class ListUsers extends StatefulWidget {
  const ListUsers({super.key});

  @override
  ListUsersState createState() => ListUsersState();
}

class ListUsersState extends State<ListUsers> {
  List<User> _workers = []; // List users
  bool _isLoading = true; // variable pour le chargement
  final ApiService apiService = ApiService(); // Instance d'ApiService

  @override
  void initState() {
    super.initState();
    _fetchWorkers();
  }

  // Récupérer les travailleurs de l'API
  Future<void> _fetchWorkers() async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1/garageparrot_api/get_workers.php'));

    if (response.statusCode == 200) {
      _isLoading = false; // désactive la circular bar

      // Convertir la réponse en une liste dynamique
      List<dynamic> data = json.decode(response.body);

      // Mettre à jour l'état de l'application
      setState(() {
        // Ajouter les travailleurs récupérés à la liste
        _workers = data.map((user) => User.fromJson(user)).toList();
      });
    } else {
      setState(() {
        _isLoading = false;// déactiver circular bar
      });
      debugPrint(
          'Échec de la récupération des travailleurs : ${response.statusCode}');   
      throw Exception('Échec de la récupération des travailleurs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Travailleurs',
            style: TextStyle(color: secondary)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: secondary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _workers.length,
              itemBuilder: (context, index) {
                final user = _workers[index];
                return WorkerInfoView(
                    user: user,
                    onDelete: (id) {
                      setState(() {
                        _workers.removeWhere((w) => w.id == id);
                      });
                      apiService.deleteUser(
                        context,
                        int.parse(id),
                        (message) => showSuccessDialog(context,message),
                        (message) => showErrorDialog(context,message),
                      );
                    });
              },
            ),
    );
  }
}

class WorkerInfoView extends StatelessWidget {
  const WorkerInfoView({
    super.key,
    required this.user,
    required this.onDelete,
  });

  final User user;
  final Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: primary,
      child: ListTile(
        textColor: secondary,
        title: Text('${user.name} ${user.lastname}',
            style: Theme.of(context).textTheme.headlineSmall),
        subtitle:
            Text(user.email, style: Theme.of(context).textTheme.bodyLarge),
        // phone icon + phone number
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.phone, color: secondary),
            Text(user.phone, style: Theme.of(context).textTheme.bodyLarge),
            // button to delete user
            IconButton(
              icon: const Icon(Icons.delete, color: secondary),
              onPressed: () {
                // delete user
                onDelete(user.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
