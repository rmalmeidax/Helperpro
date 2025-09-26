import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FrmRegistroProfissionalWidget extends StatefulWidget {
  const FrmRegistroProfissionalWidget({super.key});

  static String routeName = 'FrmRegistroProfissional';
  static String routePath = '/frmRegistroProfissional';

  @override
  State<FrmRegistroProfissionalWidget> createState() =>
      _FrmRegistroProfissionalWidgetState();
}

class _FrmRegistroProfissionalWidgetState
    extends State<FrmRegistroProfissionalWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Text controllers
  final TextEditingController workCompController = TextEditingController();
  final TextEditingController validadeController = TextEditingController();
  final TextEditingController seguro1Controller = TextEditingController();
  final TextEditingController seguro2Controller = TextEditingController();
  final TextEditingController seguro3Controller = TextEditingController();

  // Focus nodes
  final FocusNode workCompFocusNode = FocusNode();
  final FocusNode validadeFocusNode = FocusNode();
  final FocusNode seguro1FocusNode = FocusNode();
  final FocusNode seguro2FocusNode = FocusNode();
  final FocusNode seguro3FocusNode = FocusNode();

  // Dropdown values
  String seguro1Valor = 'Valor Apolice';
  String seguro2Valor = 'Valor Apolice';
  String seguro3Valor = 'Valor Apolice';

  // Checkbox states
  Map<String, bool> qualificacoes = {
    "Drywall": false,
    "Madeira": false,
    "Encanador": false,
    "Pintura": false,
    "Frame": false,
    "Tile": false,
    "Tile Piscina": false,
    "Roof": false,
    "Brick": false,
  };

  @override
  void dispose() {
    workCompController.dispose();
    validadeController.dispose();
    seguro1Controller.dispose();
    seguro2Controller.dispose();
    seguro3Controller.dispose();

    workCompFocusNode.dispose();
    validadeFocusNode.dispose();
    seguro1FocusNode.dispose();
    seguro2FocusNode.dispose();
    seguro3FocusNode.dispose();

    super.dispose();
  }

  void _salvarProfissional() {
    // Implementar lógica de salvamento aqui
    print('Salvando profissional...');
    print('Work Compensation: ${workCompController.text}');
    print('Validade: ${validadeController.text}');
    print('Seguro 1: $seguro1Valor');
    print('Seguro 2: $seguro2Valor');
    print('Seguro 3: $seguro3Valor');
    print('Qualificações: $qualificacoes');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profissional salvo com sucesso!'),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Registro Profissional"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Work Compensation
            _buildTextField(
              label: 'Work Compensation',
              controller: workCompController,
              focusNode: workCompFocusNode,
            ),
            const SizedBox(height: 16),
            // Validade
            _buildTextField(
              label: 'Validade',
              controller: validadeController,
              focusNode: validadeFocusNode,
            ),
            const SizedBox(height: 24),
            // Seguro
            Text(
              'Seguro',
              style: GoogleFonts.inter(
                color: Colors.tealAccent,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildSeguroRow('Apolice 1', seguro1Valor, (value) {
              setState(() {
                seguro1Valor = value!;
              });
            }),
            const SizedBox(height: 8),
            _buildSeguroRow('Apolice 2', seguro2Valor, (value) {
              setState(() {
                seguro2Valor = value!;
              });
            }),
            const SizedBox(height: 8),
            _buildSeguroRow('Apolice 3', seguro3Valor, (value) {
              setState(() {
                seguro3Valor = value!;
              });
            }),
            const SizedBox(height: 24),
            // Qualificação
            Text(
              'Qualificação',
              style: GoogleFonts.inter(
                color: Colors.tealAccent,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildQualificacaoGrid(),
            const SizedBox(height: 32),
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _salvarProfissional,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'SALVAR',
                    style: GoogleFonts.inter(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.teal,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        ],
      ),
    );
  }

  // Campos de texto
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          focusNode: focusNode,
          maxLines: maxLines,
          style: GoogleFonts.inter(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[900],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  // Dropdown Seguro
  Widget _buildSeguroRow(String label, String valor, ValueChanged<String?> onChanged) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: GoogleFonts.inter(color: Colors.white70),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: DropdownButtonFormField<String>(
            value: valor,
            items: const [
              DropdownMenuItem(value: 'Valor Apolice', child: Text('Valor Apolice')),
              DropdownMenuItem(value: 'Valor 1', child: Text('Valor 1')),
              DropdownMenuItem(value: 'Valor 2', child: Text('Valor 2')),
            ],
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[900],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            style: GoogleFonts.inter(color: Colors.white),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.upload_file, color: Colors.white),
        ),
      ],
    );
  }

  // Checkboxes de Qualificação
  Widget _buildQualificacaoGrid() {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: qualificacoes.keys.map((key) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: qualificacoes[key],
              onChanged: (value) {
                setState(() {
                  qualificacoes[key] = value!;
                });
              },
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.all(Colors.teal),
            ),
            Text(
              key,
              style: GoogleFonts.inter(color: Colors.white70),
            ),
            const SizedBox(width: 8),
            const Text(
              "Possui ferramenta",
              style: TextStyle(color: Colors.white70),
            ),
          ],
        );
      }).toList(),
    );
  }
}
