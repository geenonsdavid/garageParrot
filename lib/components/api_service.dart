import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:garage_parrot/components/worker.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://127.0.0.1/garageparrot_api/";

  Uri getUri(String endpoint) {
    return Uri.parse('$baseUrl$endpoint');
  }

  Future<bool> login(
    //BuildContext context,
    String email,
    String userpassword,
  ) async {
    try {
      // Préparation des données à envoyer
      final Map<String, String> loginData = {
        'email': email,
        'userpassword': userpassword,
      };

      // Envoi de la requête HTTP POST
      var res = await http.post(getUri("login.php"), body: loginData);

      // Vérifier si la réponse est réussie (code 200)
      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);
        if (response['status'] == "success") {
          return true;
        } else {
          return false;
        }
      } else {
        throw Exception("Email ou mot de passe incorrect");
      }
    } catch (e) {
      debugPrint("Erreur de requête: $e");
      throw Exception("Erreur lors de la requête: $e");
    }
  }

  Future<bool> insertWorker(Worker worker) async {
  try {
    final res = await http.post(
      getUri("insert_worker.php"),
      body: worker.toMap(),
    );

    if (res.statusCode == 200) {
      final response = jsonDecode(res.body);
      return response['success'] == true;
    } else {
      throw Exception("Erreur lors de la connexion au serveur");
    }
  } catch (e) {
    throw Exception("Erreur lors de la requête : $e");
  }
}


  Future<List<Worker>> getWorkers() async {
  try {
    var res = await http.get(getUri("get_workers.php"));

    if (res.statusCode == 200 && res.body.isNotEmpty) {
      var response = jsonDecode(res.body);

      if (response is List) {
        return response.map((workerJson) => Worker.fromJson(workerJson)).toList();
      } else {
        throw Exception("Structure de réponse inattendue");
      }
    } else {
      throw Exception("Erreur lors de la récupération des employés");
    }
  } catch (e) {
    throw Exception("Erreur lors de la requête : $e");
  }
}


// delete worker
  Future<void> deleteWorker(
    BuildContext context,
    int workerId,
    void Function(String message) showSuccessDialog,
    void Function(String message) showErrorDialog,
  ) async {
    //const String uri = "http://127.0.0.1/garageparrot_api/delete_workers.php";

    try {
      var res = await http.delete(
        getUri("delete_workers.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"id": workerId}),
      );
      //debugPrint("res : ${res.body}"); // response body
      //debugPrint("status code: ${res.statusCode}"); // response status code

      if (res.statusCode != 200) {
        showErrorDialog("Erreur lors de la connexion au serveur");
        return;
      }

      var response = jsonDecode(res.body);
      debugPrint("response $response");
      if (response["message"] == "Worker supprimé") {
        showSuccessDialog("Employé supprimé avec succès");
      } else {
        showErrorDialog("Erreur lors de la suppression de l'employé");
      }
    } catch (e) {
      debugPrint("erreur de requête: $e");
      showErrorDialog("erreur de requête: $e");
    }
  }
}
