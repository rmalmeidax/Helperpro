import 'package:flutter/material.dart';
import 'package:helperpro/registros/FrmBuscaMapWidget.dart';
import 'package:helperpro/registros/FrmRegistroAgendaWidget.dart';
import 'package:helperpro/registros/FrmRegistroProfissionalWidget.dart';
import 'FrmBuscaMapWidget.dart';
import 'FrmLoginWidget.dart';
import 'FrmPrincipalWidget.dart';
import 'FrmCadastroCliente.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Helper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Se você quer iniciar direto com FrmRegistroProfissionalWidget:
      //home: const FrmBuscaMapWidget(),

      // Rotas futuras
      routes: {
         '/': (context) => const FrmLoginWidget(title: "Welcome Helper"),
        '/frmPrincipalWidget': (context) => const FrmPrincipalWidget(),
         '/frmCadastroCliente': (context) => const FrmCadastroCliente(),
          '/frmRegistroAgendaWidget': (context) => const FrmRegistroAgendaWidget(),
          '/frmBuscaMapWidget': (context) => const FrmBuscaMapWidget(),



      },
    );
  }
}

