import 'package:flutter/material.dart';

void main() {
  runApp(const FedopiaApp());
}

class FedopiaApp extends StatelessWidget {
  const FedopiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fedopia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MaterialApp(),
    );
  }
}