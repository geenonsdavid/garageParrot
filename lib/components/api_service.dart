import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<void> insertWorker(
    List<TextEditingController> controllers,
    List<FocusNode> focusNodes,
    void Function(String message) showSuccessDialog,
    void Function(String message) showErrorDialog,
  ) async {
    if (controllers.any((controller) => controller.text.isEmpty)) {
      showErrorDialog("Veuillez remplir tous les champs");
      return;
    }

    // Préparation des données
    const String uri = "http://127.0.0.1/garageparrot_api/insert_worker.php";
    final Map<String, String> workerData = {
      "name": controllers[0].text,
      "lastname": controllers[1].text,
      "email": controllers[2].text,
      "phone": controllers[3].text,
      "userpassword": controllers[4].text,
    };
    try {
      var res = await http.post(Uri.parse(uri), body: workerData);
      debugPrint("respons: ${res.body}");
      if (res.statusCode != 200) {
        showErrorDialog("Erreur lors de la connexion au serveur");
        return;
      }

      var response = jsonDecode(res.body); //convert the response to json
      debugPrint("response en tableau: $response");

      //check if the response is successful
      if ('${response["success"]}' == "true") {
        showSuccessDialog("Employé créé avec succès");
        // Clear all controllers
        for (var controller in controllers) {
          controller.clear();
        }
      } else {
        showErrorDialog("Erreur lors de la création de l'employé");
      }
    } catch (e) {
      debugPrint("erreur de requête: $e");
      showErrorDialog("erreur de requête: $e");
    }
  }

  Future<void> getWorkers() async {
    const String uri = "http://127.0.0.1/garageparrot_api/get_workers.php";

    try {
      // send http request
      var res = await http.get(Uri.parse(uri));
      debugPrint("response: ${res.body}"); // response body
      debugPrint("status code: ${res.statusCode}"); // response status code

      // check if the response is successful
      if (res.statusCode != 200) {
        debugPrint("Erreur lors de la connexion au serveur");
        return;
      }

      if (res.body.isEmpty) {
        debugPrint("Réponse vide du serveur");
        return;
      }

      // convert the response to json
      var response = jsonDecode(res.body);

      // Si la réponse est une liste, traitez-la directement
      if (response is List) {
        debugPrint("Employés: $response");

        // Exemple de traitement de la liste des travailleurs
        for (var worker in response) {
          int id = int.tryParse(worker['id'].toString()) ??
              0; // Assurez-vous que 'id' est un int
          String name = worker['name'];
          String lastname = worker['lastname'];
          String email = worker['email'];
          String phone = worker['phone'];
          debugPrint('Worker: $id, $name $lastname, $email, $phone');
        }
      } else {
        debugPrint("Structure de réponse inattendue");
      }
      /*if (response["success"] == "true") {
      debugPrint("Employés: ${response["data"]}");
    } else {
      debugPrint("Erreur lors de la récupération des employés");
    }*/
    } catch (e) {
      debugPrint("erreur de requête: $e");
    }
  }

// delete worker
  Future<void> deleteWorker(
  BuildContext context,
  int workerId,
  void Function(String message) showSuccessDialog,
  void Function(String message) showErrorDialog,
) async {
  const String uri = "http://127.0.0.1/garageparrot_api/delete_workers.php";

  try {
    var res = await http.delete(
      Uri.parse(uri),
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


  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Erreur"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Succès"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
