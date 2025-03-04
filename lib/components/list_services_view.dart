import 'package:flutter/material.dart';
import 'package:garage_parrot/components/widget_service.dart';
import 'package:garage_parrot/components/services_data.dart';

class ListServicesView extends StatefulWidget {
  const ListServicesView({
    Key? key,
    required this.isScreenPhone,
    required this.isAdmin,
  }) : super(key: key);

  final bool isScreenPhone;
  final bool isAdmin;

  @override
  State<ListServicesView> createState() => _ListServicesState();
}

class _ListServicesState extends State<ListServicesView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Permet d'adapter la hauteur au contenu
      itemCount: servicesData.length,
      itemBuilder: (context, index) {
        final service = servicesData[index];
        final String title = service["title"].toString();
        final String image = service["image"].toString();
        final String description = service["description"].toString();
    
        // Utilisation d'une clé unique pour chaque item
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: WidgetService(
            key: ValueKey(title),  // Ajout de la clé unique
            title: title,
            image: image,
            description: description,
            isAdmin: widget.isAdmin,
            isScreenPhone: widget.isScreenPhone,
          ),
        );
      },
    );
  }
}
