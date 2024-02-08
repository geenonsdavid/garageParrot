import 'package:flutter/material.dart';
import 'package:garage_parrot/components/footer.dart';
import 'package:garage_parrot/components/form_add_service.dart';
import 'package:garage_parrot/components/form_valid_comment.dart';
import 'package:garage_parrot/components/header.dart';
import 'package:garage_parrot/components/line.dart';
import 'package:garage_parrot/views/list_services_view.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key, required this.title});

  final String title;

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    bool isScreenPhone;
    bool isAdmin = true;

    // Responsivité : détermine si l'écran est un téléphone
    if (currentWidth < 480) {
      isScreenPhone = true;
    } else {
      isScreenPhone = false;
    }

    return Scaffold(
      appBar: Header(title: widget.title, isScreenPhone: isScreenPhone),
      body: ListView(
        children: [
          Center(
            child: Text(
              'Liste des avis',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const FormValidComment(),
          const Line(),
          Center(
            child: Text(
              'Ajoutez / Modifiez un service',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const FormAddService(),
          ListServicesView(isScreenPhone: isScreenPhone, isAdmin: isAdmin),

          // Widget pour afficher le pied de page
          Footer(isScreenPhone: isScreenPhone),
        ],
      ),
    );
  }
}
