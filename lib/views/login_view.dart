import 'package:flutter/material.dart';
import 'package:garage_parrot/themes/colors.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: secondary),
        title: Text('Login',
        style: Theme.of(context).textTheme.headlineLarge,),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: background,
          border: Border.all(color: secondary, width: 2),
          borderRadius: BorderRadius.circular(10),
          ),
        
        child: const Column(
          children: [
            // field for email
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: secondary),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: secondary),
                ),
              ),
            ),
            // field for password
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: secondary),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: secondary),
                ),
              ),
            ),
            Center(
              child: Text('Login', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}