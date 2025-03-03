import 'package:flutter/material.dart';
import 'package:garage_parrot/components/footer.dart';
import 'package:garage_parrot/components/header.dart';
import 'package:garage_parrot/models/user_model.dart';
import 'package:garage_parrot/components/list_cars_view.dart';
import 'package:provider/provider.dart';

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
    bool isAdmin = Provider.of<UserModel>(context, listen: false).role == "admin";

    return Scaffold(
      appBar: Header(
        title: widget.title,
        isScreenPhone: isScreenPhone,
        userRole: isAdmin ? "admin" : "user",
      ),
      body: ListView(
        children: [
          ListCarsView(isScreenPhone: isScreenPhone, isAdmin: isAdmin),
          Footer(isScreenPhone: isScreenPhone)
        ],
      ),
    );
  }
}
