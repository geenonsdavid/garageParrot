import 'package:flutter/material.dart';
import 'package:garage_parrot/homepage.dart';
import 'package:garage_parrot/themes/colors.dart';

class Footer extends StatelessWidget {
  const Footer(
      {super.key,
      required this.widget,
      required this.isScreenPhone,
      });

  final HomePage widget;
  final bool isScreenPhone;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primary,
      child: Column(
        children: [
          // contact section
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DecoratedBox(
                    decoration:
                    BoxDecoration(
                        border: !isScreenPhone ? Border.all(
                          width: 1,
                          color: secondary,
                        ):null,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                            ),
                    child: Column(
                      children: [
                        Text('Nous contacter',
                            style: Theme.of(context).textTheme.headlineMedium),
                        Container(
                          constraints: const BoxConstraints(
                            minWidth: 200,
                          ),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: secondary,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                              ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top:8),
                                  child: Text('Téléphone',
                                      style: Theme.of(context).textTheme.bodyLarge),
                                ),
                                Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Text('07 83 55 20 17',
                                      style: Theme.of(context).textTheme.bodyLarge),
                                    ),
                              ],
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('Formulaire de contact',
                              style: Theme.of(context).textTheme.labelLarge),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // horaire section
          Container(
            color: secondary,
            child: SizedBox.fromSize(
              size: const Size(100, 2),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Widget Horaire'),
            ],
          ),
        ],
      ),
    );
  }
}
