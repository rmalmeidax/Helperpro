import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class FrmCadastroCliente extends StatefulWidget {
  const FrmCadastroCliente({super.key});

  static String routeName = 'FrmCadastroCliente';
  static String routePath = '/frmCadastroCliente';

  @override
  State<FrmCadastroCliente> createState() => _FrmCadastroClienteState();
}

class _FrmCadastroClienteState extends State<FrmCadastroCliente> {
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Text controllers
  final TextEditingController nomeClienteController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController observacaoController = TextEditingController();

  @override
  void dispose() {
    nomeClienteController.dispose();
    enderecoController.dispose();
    cidadeController.dispose();
    estadoController.dispose();
    cepController.dispose();
    telefoneController.dispose();
    observacaoController.dispose();
    super.dispose();
  }

  void _salvarCliente() {
    if (_formKey.currentState!.validate()) {
      print('Salvando cliente...');
      print('Nome: ${nomeClienteController.text}');
      print('Endereço: ${enderecoController.text}');
      print('Cidade: ${cidadeController.text}');
      print('Estado: ${estadoController.text}');
      print('CEP: ${cepController.text}');
      print('Telefone: ${telefoneController.text}');
      print('Observação: ${observacaoController.text}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cliente salvo com sucesso!'),
          backgroundColor: Colors.blueGrey,
        ),
      );

      // Limpar campos
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              height: 60,
              color: Colors.grey[300],
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24), // espaço para indicador futuro
                  Text(
                    'Registro de Clientes',
                    style: GoogleFonts.inter(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black87,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            // Form
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      // Nome Cliente
                      _buildTextField(
                        label: 'Nome Cliente',
                        controller: nomeClienteController,
                        isRequired: true,
                      ),
                      const SizedBox(height: 16),
                      // Endereço
                      _buildTextField(
                        label: 'Endereço',
                        controller: enderecoController,
                      ),
                      const SizedBox(height: 16),
                      // Cidade e Estado
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              label: 'Cidade',
                              controller: cidadeController,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              label: 'Estado',
                              controller: estadoController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // CEP e Telefone
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              label: 'CEP',
                              controller: cepController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              label: 'Telefone',
                              controller: telefoneController,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Observação
                      _buildTextField(
                        label: 'Observação',
                        controller: observacaoController,
                        maxLines: 4,
                        minLines: 4,
                      ),
                      const SizedBox(height: 32),
                      // Botão Salvar
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _salvarCliente,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF39D2C0),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'SALVAR',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool isRequired = false,
    int maxLines = 1,
    int minLines = 1,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label,
                style: GoogleFonts.inter(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          minLines: minLines,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          style: GoogleFonts.inter(
            color: Colors.black87,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            hintText: '',
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: isRequired ? const Color(0xFFFF6B35) : const Color(0xFF39D2C0),
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          validator: isRequired
              ? (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null
              : null,
        ),
      ],
    );
  }
}
