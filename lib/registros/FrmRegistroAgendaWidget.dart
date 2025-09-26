import 'package:flutter/material.dart';

void main() {
  runApp(const FrmRegistroAgendaWidget());
}

class FrmRegistroAgendaWidget extends StatelessWidget {
  const FrmRegistroAgendaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda de Atividades',
      debugShowCheckedModeBanner: false,
      home: const AgendaPage(),
    );
  }
}

class AgendaPage extends StatelessWidget {
  const AgendaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final clientes = [
      const Cliente(
        nome: "[Manoel Green]",
        endereco: "[endereco_trab]",
        servicos: [
          Servico(inicio: "[yyd]", previsao: "[yyd]", termino: "[yyd]", credito: 0, debito: 0),
          Servico(inicio: "[yyd]", previsao: "[yyd]", termino: "[yyd]", credito: 0, debito: 0),
        ],
      ),
      const Cliente(
        nome: "[Helena Pink]",
        endereco: "[endereco_trab]",
        servicos: [
          Servico(inicio: "[yyd]", previsao: "[yyd]", termino: "[yyd]", credito: 0, debito: 0),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Atividades",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.blueAccent),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.filter_alt, color: Colors.blueAccent),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: clientes.length,
        itemBuilder: (context, idxCliente) {
          final cliente = clientes[idxCliente];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            color: Colors.teal.shade900.withOpacity(0.7), // fundo escuro translúcido
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ExpansionTile(
              collapsedIconColor: Colors.white,
              iconColor: Colors.white,
              title: Text(cliente.nome,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text(cliente.endereco, style: const TextStyle(color: Colors.white70)),
              children: cliente.servicos.map((servico) {
                return GestureDetector(
                  onTap: () {
                    // ✅ Futuro: linkar para detalhes
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => DetalhesServicoPage(servico: servico)),
                    // );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.teal.shade700, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Início: ${servico.inicio}",
                            style: const TextStyle(color: Colors.white, fontSize: 13)),
                        Text("Previsão: ${servico.previsao}",
                            style: const TextStyle(color: Colors.white, fontSize: 13)),
                        Text("Término: ${servico.termino}",
                            style: const TextStyle(color: Colors.white, fontSize: 13)),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Crédito: R\$ ${servico.credito.toStringAsFixed(2)}",
                                style: const TextStyle(color: Colors.white, fontSize: 13)),
                            Text("Débito: R\$ ${servico.debito.toStringAsFixed(2)}",
                                style: const TextStyle(color: Colors.white, fontSize: 13)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Saldo:",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            Text(
                              "R\$ ${servico.saldo.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: servico.saldo >= 0 ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.grey[300], // rodapé cinza claro
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Crédito:", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                Text("R\$ 0.00", style: TextStyle(color: Colors.black)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Compras:", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                Text("R\$ 0.00", style: TextStyle(color: Colors.red)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Mão de Obra:", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                Text("R\$ 0.00", style: TextStyle(color: Colors.red)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Saldo:", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                Text("R\$ 0.00", style: TextStyle(color: Colors.black)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== MODELOS ====================
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
