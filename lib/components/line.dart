import 'package:flutter/material.dart';
import '../themes/colors.dart';

class Line extends StatelessWidget {
  const Line({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: secondary,
            child: SizedBox.fromSize(
              size: const Size(100, 2),
            ),
          ),
        ],
      ),
    );
  }
}