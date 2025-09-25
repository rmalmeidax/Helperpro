import 'package:flutter/material.dart';
import 'package:helperpro/registros/FrmRegistroProfissionalWidget.dart';
import 'FrmLoginWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Helper Pro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const FrmRegistroProfissionalWidget(),
    );
  }
}