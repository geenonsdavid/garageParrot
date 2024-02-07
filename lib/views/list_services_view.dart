import 'package:flutter/material.dart';
import 'package:garage_parrot/components/service.dart';
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
    return Column(
      children: servicesData.map((service) {
        final String title = service["title"].toString();
        final String image = service["image"].toString();
        final String description = service["description"].toString();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Service(
            title: title,
            image: image,
            description: description,
            isAdmin: widget.isAdmin,
            isScreenPhone: widget.isScreenPhone,
          ),
        );
      }).toList(),
    );
  }
}
