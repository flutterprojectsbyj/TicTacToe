import 'package:flutter/material.dart';
import 'package:tictactoe/pages/menu.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true
      ),
      themeMode: ThemeMode.dark,
      home: const Menu(),
    );
  }
}