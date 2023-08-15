import 'package:flutter/material.dart';
import '/screens/password_generator_screen.dart';
import '/screens/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Key Genius',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PasswordGeneratorScreen(),
    );
  }
}
