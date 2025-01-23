import 'package:flutter/material.dart';
import 'package:garage_parrot/components/footer.dart';
import 'package:garage_parrot/components/onlogoutpressed.dart';
import 'package:garage_parrot/views/list_services_view.dart';
import '../components/header.dart';


class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    const isAdmin = false;
    bool isScreenPhone;

    // Responsivité : détermine si l'écran est un téléphone
    MediaQuery.of(context).size.width < 480 ? isScreenPhone = true : isScreenPhone = false;

    return Scaffold(
      appBar: Header(title: widget.title, isScreenPhone: isScreenPhone, onLogoutPressed: () => onLogoutPressed(context),),
      body: ListView(
        children: [
          ListServicesView(isScreenPhone: isScreenPhone, isAdmin: isAdmin),

          // Widget pour afficher le pied de page
          Footer(isScreenPhone: isScreenPhone),
          
        ],
      ),
    );
  }
}



