// Importa o pacote Flutter Material (componentes visuais padrão)
import 'package:flutter/material.dart';

// Define a tela de login como um StatefulWidget
class FrmLoginWidget1 extends StatefulWidget {
  // Parâmetro que será passado para o título da tela
  final String title;

  // Construtor obrigatório com a chave e o título
  const FrmLoginWidget1({super.key, required this.title});

  @override
  State<FrmLoginWidget1> createState() => _FrmLoginWidgetState();
}

// Estado da tela de login
class _FrmLoginWidgetState extends State<FrmLoginWidget1> {
  @override
  Widget build(BuildContext context) {
    // Scaffold é a estrutura básica da tela
    return Scaffold(
      // AppBar com o título recebido do widget
      appBar: AppBar(title: Text(widget.title)),

      // Corpo da tela centralizado
      body: Center(
        // Texto simples apenas para exemplo
        child: Text('Tela de Login'),
      ),
    );
  }
}
