import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: Header(widget: widget, currentWidth: currentWidth),
      body: Column(
        children: [
          const Text('boby'),
          ElevatedButton(
              onPressed: () {}, child: const Icon(Icons.ac_unit_rounded))
        ],
      ),
    );
  }
}


