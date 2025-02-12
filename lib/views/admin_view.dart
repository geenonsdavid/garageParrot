import 'package:flutter/material.dart';
import 'package:garage_parrot/components/footer.dart';
import 'package:garage_parrot/components/form_add_service.dart';
import 'package:garage_parrot/components/form_add_worker.dart';
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

    bool isAdmin = true;

    // Responsivité : détermine si l'écran est un téléphone
    bool isScreenPhone = currentWidth < 480;

    return Scaffold(
      appBar: Header(title: widget.title, isScreenPhone: isScreenPhone),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle("Liste des avis"),
          const FormValidComment(),
          const Line(),
          _buildSectionTitle("Ajoutez un employé"),
          const FormAddWorker(),
          const SizedBox(height: 20),
          _buildSectionTitle("Ajoutez / Modifiez un service"),
          const FormAddService(),
          const SizedBox(height: 20),
          ListServicesView(isScreenPhone: isScreenPhone, isAdmin: isAdmin),
          const SizedBox(height: 20),
          Footer(isScreenPhone: isScreenPhone),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
