import 'package:flutter/material.dart';
import 'package:garage_parrot/themes/colors.dart';

class ListWorker extends StatelessWidget {
  const ListWorker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des employés',style: Theme.of(context).textTheme.headlineSmall),
        iconTheme: const IconThemeData(color: secondary),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Employé $index'),
            subtitle: Text('Employé $index'),
            leading: const Icon(Icons.person),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              print("click");
            },
          );
        },
      ),
    );
  }
}
