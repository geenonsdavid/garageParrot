import 'package:flutter/material.dart';
import 'package:garage_parrot/components/footer.dart';
import 'package:garage_parrot/components/header.dart';
import 'package:garage_parrot/components/list_services_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    const isAdmin = false;
    final currentWidth = MediaQuery.of(context).size.width;
    bool isScreenPhone;

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
          ListServicesView(isScreenPhone: isScreenPhone, isAdmin: isAdmin),

          // Widget pour afficher le pied de page
          Footer(isScreenPhone: isScreenPhone),

          // Bouton d'action flottant
          FloatingActionButton(
            child: const Icon(Icons.abc),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}



