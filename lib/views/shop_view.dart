import 'package:flutter/material.dart';
import 'package:garage_parrot/components/footer.dart';
import 'package:garage_parrot/components/header.dart';


class ShopView extends StatefulWidget {
  const ShopView({super.key, required this.title});

  final String title;

  @override
  State<ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  @override
  Widget build(BuildContext context) {
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
          const Text('Galerie'),

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



