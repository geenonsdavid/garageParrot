import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


















































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

class ApiService {
  Future<void> insertRecord(BuildContext context,
    List<TextEditingController> controllers, List<FocusNode> focusNodes) async {
  if (controllers.any((controller) => controller.text.isEmpty)) {
    if (context.mounted) {
      showErrorDialog(context, "Veuillez remplir tous les champs");
    }
    return;
  }

  try {
    String uri = "http://192.168.1.69/garageparrot_api/insert_record.php";

    var res = await http.post(Uri.parse(uri), body: {
      "name": controllers[0].text,
      "lastname": controllers[1].text,
      "email": controllers[2].text,
      "phone": controllers[3].text,
    });
    debugPrint("response: ${res.body}");
    if (res.statusCode != 200) {
      if (context.mounted) {
        showErrorDialog(context, "Erreur lors de la connexion au serveur");
      }
      return;
    }

    if (res.body.isEmpty) {
      if (context.mounted) {
        showErrorDialog(context, "Réponse vide du serveur");
      }
      return;
    }

    var response = jsonDecode(res.body);
    if (context.mounted) {
      if (response["success"] == "true") {
        showSuccessDialog(context, "Employé créé avec succès");
        // Clear all controllers
        for (var controller in controllers) {
          controller.clear();
        }
      } else {
        showErrorDialog(context, "Erreur lors de la création de l'employé");
      }
    }
  } catch (e) {
    if (context.mounted) {
      debugPrint("erreur de requête: $e");
      showErrorDialog(context, "erreur de requête: $e");
    }
  }
}


  Future<bool> login(Map<String, String> data) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.69/garageparrot_api/login.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      debugPrint("response: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // Assurez-vous que la réponse contient un champ indiquant le succès de la connexion
        return responseData['success'];
      } else {
        // Gérer les erreurs de la requête
        return false;
      }
    } catch (e) {
      // Gérer les erreurs de la requête
      debugPrint("erreur de requête: $e");
      return false;
    }
  }
}
