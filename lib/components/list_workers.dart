import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:garage_parrot/components/dialog_helpers.dart';
import 'package:garage_parrot/components/worker.dart';
import 'package:garage_parrot/themes/colors.dart';
import 'package:garage_parrot/components/api_service.dart';
import 'package:http/http.dart' as http;

class ListWorkers extends StatefulWidget {
  const ListWorkers({super.key});

  @override
  ListWorkersState createState() => ListWorkersState();
}

class ListWorkersState extends State<ListWorkers> {
  List<Worker> _workers = []; // List workers
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
        _workers = data.map((worker) => Worker.fromJson(worker)).toList();
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
                final worker = _workers[index];
                return WorkerInfoView(
                    worker: worker,
                    onDelete: (id) {
                      setState(() {
                        _workers.removeWhere((w) => w.id == id);
                      });
                      apiService.deleteWorker(
                        context,
                        int.parse(id),
                        (message) => showSuccessDialog(context, message),
                        (message) => showErrorDialog(context, message),
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
    required this.worker,
    required this.onDelete,
  });

  final Worker worker;
  final Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: primary,
      child: ListTile(
        textColor: secondary,
        title: Text('${worker.name} ${worker.lastname}',
            style: Theme.of(context).textTheme.headlineSmall),
        subtitle:
            Text(worker.email, style: Theme.of(context).textTheme.bodyLarge),
        // phone icon + phone number
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.phone, color: secondary),
            Text(worker.phone, style: Theme.of(context).textTheme.bodyLarge),
            // button to delete worker
            IconButton(
              icon: const Icon(Icons.delete, color: secondary),
              onPressed: () {
                // delete worker
                onDelete(worker.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
