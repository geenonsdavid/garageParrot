import 'package:flutter/material.dart';
import 'package:garage_parrot/components/footer.dart';
import 'components/header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    bool isScreenPhone;
    // responsive logo
    if (currentWidth < 480) {
      isScreenPhone = true;
    } else {
      isScreenPhone = false;
    }
    return Scaffold(
      appBar: Header(widget: widget,isScreenPhone: isScreenPhone),
      body: ListView(
        children: [

          const Text('boby'),
          Footer(widget: widget, isScreenPhone: isScreenPhone),
          FloatingActionButton(
            child: const Icon(Icons.abc),
            onPressed: (){},
          ),
        ],
      ),
    );
  }
}


