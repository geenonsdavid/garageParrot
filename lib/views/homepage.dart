import 'package:flutter/material.dart';
import 'package:garage_parrot/components/footer.dart';
import 'package:garage_parrot/models/user_model.dart';
import 'package:garage_parrot/components/list_services_view.dart';
import 'package:provider/provider.dart';
import '../components/header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final userRole = Provider.of<UserModel>(context).userRole;
    final bool isAdmin = userRole == "admin";

    final currentWidth = MediaQuery.of(context).size.width;
    final bool isScreenPhone = currentWidth < 480;

    return Scaffold(
      appBar: Header(
        title: widget.title,
        isScreenPhone: isScreenPhone,
        userRole: isAdmin ? "admin" : "user",
      ),
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
