import 'package:flutter/material.dart';
import '../themes/colors.dart';

class PhoneSection extends StatelessWidget {
  const PhoneSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String phoneNumber = '07 83 55 20 17';
    return Container(
      constraints: const BoxConstraints(minWidth: 300),
      padding: const EdgeInsets.all(8),
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
          Text('Téléphone',
              style: Theme.of(context).textTheme.headlineSmall,),
          Text(phoneNumber,
          style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}