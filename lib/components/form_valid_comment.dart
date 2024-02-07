import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_parrot/components/comment.dart';
import 'package:garage_parrot/list_comment.dart';
import 'package:garage_parrot/themes/colors.dart';

class FormValidComment extends StatefulWidget {
  const FormValidComment({super.key});

  @override
  State<FormValidComment> createState() => _FormValidCommentState();
}

class _FormValidCommentState extends State<FormValidComment> {
  List<Map<String, dynamic>> validatedComments = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'cochez les avis à validez',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.black,
                    ),
              ),
            ],
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                        value: comments[index]["valid"],
                        onChanged: (bool? value) {
                          setState(() {
                            comments[index]["valid"] = value;
                          });
                        }),
                    Comment(
                      pseudoMessage: comments[index]["pseudoMessage"],
                      message: comments[index]["message"],
                    ),
                  ],
                ),
              );
            },
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
                onPressed: () {
                  // afficher les messages validez
                  setState(
                    () {
                      validatedComments.clear();
                      for (var message in comments) {
                        if (message["valid"] == true) {
                          validatedComments.add(message);
                        }
                      }
                      debugPrint(validatedComments.toString());
                    },
                  );
                },
                icon: SvgPicture.asset(
                  "../assets/icons/check2-circle.svg",
                  height: 25,
                  colorFilter: const ColorFilter.mode(secondary, BlendMode.srcIn),
                ),
                label: const Text("Validez")),
          )
        ],
      ),
    );
  }
}
