import 'package:flutter/material.dart';

void main() {
  runApp(const AgendaApp());
}

class AgendaApp extends StatelessWidget {
  const AgendaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda de Atividades',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AgendaPage(),
    );
  }
}

class Servico {
  final String inicio;
  final String previsao;
  final String termino;
  final double credito;
  final double debito;

  const Servico({
    required this.inicio,
    required this.previsao,
    required this.termino,
    required this.credito,
    required this.debito,
  });

  double get saldo => credito - debito;
}

class Cliente {
  final String nome;
  final String endereco;
  final List<Servico> servicos;

  const Cliente({
    required this.nome,
    required this.endereco,
    required this.servicos,
  });
}

class AgendaPage extends StatelessWidget {
  const AgendaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final clientes = [
      const Cliente(
        nome: "João Silva",
        endereco: "Rua A, 123",
        servicos: [
          Servico(
            inicio: "01/10/2025",
            previsao: "05/10/2025",
            termino: "06/10/2025",
            credito: 1500.0,
            debito: 500.0,
          ),
          Servico(
            inicio: "10/10/2025",
            previsao: "15/10/2025",
            termino: "16/10/2025",
            credito: 2000.0,
            debito: 2200.0, // saldo negativo para teste
          ),
        ],
      ),
      const Cliente(
        nome: "Maria Oliveira",
        endereco: "Av. Central, 456",
        servicos: [
          Servico(
            inicio: "20/09/2025",
            previsao: "25/09/2025",
            termino: "26/09/2025",
            credito: 1000.0,
            debito: 300.0,
          ),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Agenda de Atividades")),
      body: ListView.builder(
        itemCount: clientes.length,
        itemBuilder: (context, idxCliente) {
          final cliente = clientes[idxCliente];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: Text(cliente.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(cliente.endereco),
              children: cliente.servicos.asMap().entries.map((entry) {
                final index = entry.key;
                final servico = entry.value;
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.shade100),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      title: Text("Serviço ${index + 1}", style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          Text("Início: ${servico.inicio}"),
                          Text("Previsão: ${servico.previsao}"),
                          Text("Término: ${servico.termino}"),
                          const SizedBox(height: 8),
                          Text("Crédito: R\$ ${servico.credito.toStringAsFixed(2)}"),
                          Text("Débito: R\$ ${servico.debito.toStringAsFixed(2)}"),
                        ],
                      ),
                      // Aqui exibimos o SALDO (linha importante)
                      trailing: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Saldo", style: TextStyle(fontSize: 12)),
                          const SizedBox(height: 4),
                          Text(
                            "R\$ ${servico.saldo.toStringAsFixed(2)}", // <- saldo mostrado aqui
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: servico.saldo >= 0 ? Colors.green.shade700 : Colors.red.shade700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
