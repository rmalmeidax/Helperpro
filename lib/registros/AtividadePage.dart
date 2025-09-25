import 'package:flutter/material.dart';

class AtividadePage extends StatelessWidget {
  final bool isVisitor; // true se for visitante

  const AtividadePage({Key? key, this.isVisitor = true}) : super(key: key);

  List<Map<String, dynamic>> get atividades => [
  {
  'nome': 'Cliente 1',
  'endereco': 'Rua A, 123',
  'telefone': '1234-5678',
  'inicio': '2025-09-25',
  'previsao': '2025-09-28',
  'termino': '2025-09-30',
  'credito': 1500.0,
  'debito': 200.0,
  'saldo': 1300.0,
  },
  {
  'nome': 'Cliente 2',
  'endereco': 'Rua B, 456',
  'telefone': '9876-5432',
  'inicio': '2025-09-26',
  'previsao': '2025-09-29',
  'termino': '2025-10-01',
  'credito': 2000.0,
  'debito': 500.0,
  'saldo': 1500.0,
  },
  {
  'nome': 'Cliente 3',
  'endereco': 'Av. Central, 789',
  'telefone': '5555-1234',
  'inicio': '2025-09-27',
  'previsao': '2025-10-02',
  'termino': '2025-10-05',
  'credito': 800.0,
  'debito': 150.0,
  'saldo': 650.0,
  },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context); // Volta para a página anterior
          },
        ),
        title: const Text(
          "Detalhes das Atividades",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: "Voltar ao Início",
            onPressed: () {
              // Volta para a página principal (remove todas as páginas da pilha)
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header com informações do usuário
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              border: Border(bottom: BorderSide(color: Colors.teal.shade200)),
            ),
            child: Row(
              children: [
                Icon(
                  isVisitor ? Icons.visibility : Icons.person,
                  color: Colors.teal,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  isVisitor ? "Modo Visitante" : "Modo Completo",
                  style: TextStyle(
                    color: Colors.teal.shade700,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          // Lista de atividades
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: atividades.length,
              itemBuilder: (context, index) {
                final atividade = atividades[index];
                return Card(
                  elevation: 4,
                  color: Colors.teal.shade700,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nome do cliente
                        Row(
                          children: [
                            const Icon(Icons.person, color: Colors.white, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                atividade['nome'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Endereço
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.white70, size: 16),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                atividade['endereco'],
                                style: const TextStyle(color: Colors.white70, fontSize: 14),
                              ),
                            ),
                          ],
                        ),

                        // Telefone (só aparece se não for visitante)
                        if (!isVisitor) ...[
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.phone, color: Colors.white70, size: 16),
                              const SizedBox(width: 8),
                              Text(
                                atividade['telefone'],
                                style: const TextStyle(color: Colors.white70, fontSize: 14),
                              ),
                            ],
                          ),
                        ],

                        const SizedBox(height: 12),

                        // Datas e valores
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Coluna das datas
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildDateRow("Início", atividade['inicio']),
                                  const SizedBox(height: 4),
                                  _buildDateRow("Previsão", atividade['previsao']),
                                  const SizedBox(height: 4),
                                  _buildDateRow("Término", atividade['termino']),
                                ],
                              ),
                            ),

                            // Coluna dos valores
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  _buildValueRow("Crédito", atividade['credito'], Colors.greenAccent),
                                  const SizedBox(height: 4),
                                  _buildValueRow("Débito", atividade['debito'], Colors.redAccent),
                                  const SizedBox(height: 4),
                                  _buildValueRow("Saldo", atividade['saldo'], Colors.white),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // Botão flutuante para voltar ao início
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.popUntil(context, (route) => route.isFirst);
        },
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        tooltip: "Voltar ao Início",
        child: const Icon(Icons.home),
      ),
    );
  }

  Widget _buildDateRow(String label, String date) {
    return Row(
      children: [
        Text(
          "$label: ",
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          date,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildValueRow(String label, double value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "$label: ",
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "R\$ ${value.toStringAsFixed(2)}",
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}