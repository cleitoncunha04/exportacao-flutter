import 'package:flutter/material.dart';
import 'package:projetinho_final/data/mysql/mysql_db.dart';
import 'package:projetinho_final/pages/loginPage.dart';

void main() async {
  await MySqlDb().inicialize();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final tema = ThemeData();
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.black87,
          secondary: Colors.grey,
          error: Colors.indigo[200],
        ),
        textTheme: tema.textTheme.copyWith(
          headlineSmall: TextStyle(
            fontSize: 19,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: Scaffold(
        body: LoginPage(),
      ),
    );
  }
}
