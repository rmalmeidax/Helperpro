import 'package:flutter/material.dart';

class FrmCriarOrcamentoWidget extends StatefulWidget {
  const FrmCriarOrcamentoWidget({Key? key}) : super(key: key);

  @override
  _FrmCriarOrcamentoWidgetState createState() =>
      _FrmCriarOrcamentoWidgetState();
}

class _FrmCriarOrcamentoWidgetState extends State<FrmCriarOrcamentoWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController amountController = TextEditingController();
  final TextEditingController budgetNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    budgetNameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white, // fundo branco
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Cabeçalho
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Criar Orçamento',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, size: 28),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Campo Valor
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Valor',
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: const Icon(Icons.attach_money_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Campo Nome do Orçamento
            TextFormField(
              controller: budgetNameController,
              decoration: InputDecoration(
                hintText: 'Nome do Orçamento',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Campo Descrição
            TextFormField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Descrição',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Botão Criar Orçamento
            ElevatedButton(
              onPressed: () {
                final amount = amountController.text;
                final name = budgetNameController.text;
                final description = descriptionController.text;

                // Aqui você pode salvar no Firebase ou usar qualquer lógica
                print('Criando orçamento: $name, Valor: $amount, Desc: $description');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
              ),
              child: const Text(
                'Criar Orçamento',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Toque acima para concluir a solicitação',
              style: TextStyle(color: Colors.black45),
            ),
          ],
        ),
      ),
    );
  }
}
