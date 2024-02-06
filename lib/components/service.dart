import 'package:flutter/material.dart';
import 'package:garage_parrot/themes/colors.dart';

class Service extends StatelessWidget {
  const Service({
    super.key,
    required this.title,
    required this.image,
    required this.description,
    required this.isAdmin,
    required this.isScreenPhone,
  });

  final String title;
  final String image;
  final String description;
  final bool isAdmin;
  final bool isScreenPhone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: primary,
        border: Border.all(
          color: secondary,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: [
          isScreenPhone ?
          Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Image.asset(
                  image,
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                    ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 300,
            
            child: Card(
              elevation: 4,
              shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8),),
              ),
              child: Column(
                children: [
                Text(title,
                style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 8,),
              Text(description),
                ],
              ),
            ),
          ),
            ],
          )
          :
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Column(
              children: [
                ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Image.asset(
                  image,
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                    ),
              ],
            ),
            const SizedBox(width: 8,),
          Expanded(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(
                    minHeight: 200,
                  ),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(title,
                      style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8,),
                      Text(description),
                    ],
                                  ),
                  ),),
              ],
            ),
          ),
          ],
          ),
          const SizedBox(
            height: 8,
          ),
          if (isAdmin)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                    onPressed: () {}, child: const Text("Supprimer")),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: () {}, child: const Text("Modifier")),
              ],
            ),
        ],
      ),
    );
  }
}
