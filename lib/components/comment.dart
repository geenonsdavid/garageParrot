import 'package:flutter/material.dart';

class Comment extends StatefulWidget {
  const Comment({
    required this.pseudoMessage,
    required this.message,
    super.key});

 final String pseudoMessage;
 final String message;

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.pseudoMessage,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.black,
            ),
          ),
          const Text(' * * * * *'),
          Text(widget.message),
        ],
      ),
    );
  }
}
