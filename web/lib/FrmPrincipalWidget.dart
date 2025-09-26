import 'package:flutter/material.dart';

class FrmPrincipalWidget extends StatelessWidget {
  const FrmPrincipalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela Principal')),
      body: const Center(child: Text('Bem-vindo à tela principal!')),
    );
  }
}
