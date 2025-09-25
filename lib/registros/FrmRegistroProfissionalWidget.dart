import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

/// Widget principal do formulário de registro profissional
/// Implementa o design conforme a imagem fornecida
class FrmRegistroProfissionalWidget extends StatefulWidget {
  const FrmRegistroProfissionalWidget({super.key});

  @override
  State<FrmRegistroProfissionalWidget> createState() => _FrmRegistroProfissionalWidgetState();
}

class _FrmRegistroProfissionalWidgetState extends State<FrmRegistroProfissionalWidget> {
  // Chave global do formulário para validação
  final _formKey = GlobalKey<FormState>();

  // Controladores dos campos de texto
  final _nomeController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _cepController = TextEditingController();
  final _estadoController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _empresaController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _dataEmissaoController = TextEditingController();
  final _workCompensationController = TextEditingController();
  final _validadeController = TextEditingController();

  // Variáveis para controle de estado
  File? _imagemPerfil;
  final ImagePicker _picker = ImagePicker();
  String? _qualificacaoSelecionada;

  // Lista de qualificações disponíveis
  final List<String> _qualificacoes = [
    'Desenvolvedor Flutter',
    'Designer UI/UX',
    'Desenvolvedor Web',
    'Desenvolvedor Mobile',
    'Analista de Sistemas',
    'Gerente de Projetos',
    'DevOps',
    'Teste de Software',
    'Arquiteto de Software',
    'Consultor Técnico'
  ];

  /// Função para selecionar imagem da galeria ou câmera
  Future<void> _selecionarImagem() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library, color: Colors.black),
                  title: const Text('Galeria', style: TextStyle(color: Colors.black)),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final XFile? imagem = await _picker.pickImage(source: ImageSource.gallery);
                    if (imagem != null) {
                      setState(() {
                        _imagemPerfil = File(imagem.path);
                      });
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera, color: Colors.black),
                  title: const Text('Câmera', style: TextStyle(color: Colors.black)),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final XFile? imagem = await _picker.pickImage(source: ImageSource.camera);
                    if (imagem != null) {
                      setState(() {
                        _imagemPerfil = File(imagem.path);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Widget personalizado para criar campos de texto com o estilo da imagem
  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String label,
    required String placeholder,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          enabled: enabled,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(color: Colors.grey.shade600),
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4FD1C7), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  /// Widget para o dropdown de qualificação
  Widget _buildQualificacaoDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Qualificação',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _qualificacaoSelecionada,
          style: const TextStyle(color: Colors.black),
          dropdownColor: Colors.white,
          decoration: InputDecoration(
            hintText: 'Qualificação',
            hintStyle: TextStyle(color: Colors.grey.shade600),
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4FD1C7), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
          items: _qualificacoes.map((String qualificacao) {
            return DropdownMenuItem<String>(
              value: qualificacao,
              child: Text(qualificacao, style: const TextStyle(color: Colors.black)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _qualificacaoSelecionada = newValue;
            });
          },
        ),
      ],
    );
  }

  /// Widget para campos em linha (lado a lado)
  Widget _buildRowFields({
    required Widget field1,
    required Widget field2,
    double spacing = 12,
  }) {
    return Row(
      children: [
        Expanded(child: field1),
        SizedBox(width: spacing),
        Expanded(child: field2),
      ],
    );
  }

  /// Widget para campos em linha com 3 elementos
  Widget _buildTripleRowFields({
    required Widget field1,
    required Widget field2,
    required Widget field3,
    double spacing = 12,
  }) {
    return Row(
      children: [
        Expanded(child: field1),
        SizedBox(width: spacing),
        Expanded(child: field2),
        SizedBox(width: spacing),
        Expanded(child: field3),
      ],
    );
  }

  /// Widget para botões com ícone azul
  Widget _buildIconButton({
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF4FD1C7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
      ),
    );
  }

  /// Função para salvar os dados do profissional
  void _salvarProfissional() {
    if (_formKey.currentState!.validate()) {
      // Validação adicional para qualificação
      if (_qualificacaoSelecionada == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Selecione uma qualificação!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Aqui você salvaria os dados do profissional
      // Por exemplo, em um banco de dados ou lista

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profissional cadastrado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      // Limpar formulário após salvar
      _limparFormulario();
    }
  }

  /// Função para limpar todos os campos do formulário
  void _limparFormulario() {
    _nomeController.clear();
    _enderecoController.clear();
    _cidadeController.clear();
    _cepController.clear();
    _estadoController.clear();
    _telefoneController.clear();
    _empresaController.clear();
    _cnpjController.clear();
    _dataEmissaoController.clear();
    _workCompensationController.clear();
    _validadeController.clear();

    setState(() {
      _imagemPerfil = null;
      _qualificacaoSelecionada = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar com gradiente turquesa conforme a imagem
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: const Color(0xFF4FD1C7),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      // Body com fundo branco
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Seção do avatar e botão trocar foto
                Center(
                  child: Column(
                    children: [
                      // Ícone de perfil
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                          border: Border.all(
                            color: Colors.grey.shade400,
                            width: 2,
                          ),
                        ),
                        child: _imagemPerfil != null
                            ? ClipOval(
                          child: Image.file(
                            _imagemPerfil!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        )
                            : const Icon(
                          Icons.person_add,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Botão "Trocar Foto"
                      ElevatedButton(
                        onPressed: _selecionarImagem,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          side: BorderSide(color: Colors.grey.shade400),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        ),
                        child: const Text('Trocar Foto'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Campo Nome
                _buildCustomTextField(
                  controller: _nomeController,
                  label: 'Nome',
                  placeholder: '[display_name]',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Campo Endereço
                _buildCustomTextField(
                  controller: _enderecoController,
                  label: 'Endereço',
                  placeholder: '[endereco]',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o endereço';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Campos Cidade, CEP e Estado em linha
                _buildTripleRowFields(
                  field1: _buildCustomTextField(
                    controller: _cidadeController,
                    label: 'Cidade',
                    placeholder: '[cidade]',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira a cidade';
                      }
                      return null;
                    },
                  ),
                  field2: _buildCustomTextField(
                    controller: _cepController,
                    label: 'ZipCode',
                    placeholder: '[cep]',
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(8),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira o CEP';
                      }
                      return null;
                    },
                  ),
                  field3: _buildCustomTextField(
                    controller: _estadoController,
                    label: 'Estado',
                    placeholder: '[estado]',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira o estado';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // Campos Telefone e Qualificação em linha
                _buildRowFields(
                  field1: _buildCustomTextField(
                    controller: _telefoneController,
                    label: 'Telefone',
                    placeholder: '[phone_number]',
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira o telefone';
                      }
                      if (value.length < 10) {
                        return 'Telefone inválido';
                      }
                      return null;
                    },
                  ),
                  field2: _buildQualificacaoDropdown(),
                ),

                const SizedBox(height: 32),

                // Seção "Dados Comerciais"
                const Center(
                  child: Text(
                    'Dados Comerciais',
                    style: TextStyle(
                      color: Color(0xFF4FD1C7),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Campo Companhia
                _buildCustomTextField(
                  controller: _empresaController,
                  label: 'Companhia',
                  placeholder: '[empresa]',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a empresa';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Campos CNPJ e Data de Emissão com botão
                Row(
                  children: [
                    Expanded(
                      child: _buildCustomTextField(
                        controller: _cnpjController,
                        label: 'EIN Number',
                        placeholder: '[cnpj_emp]',
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Insira o CNPJ';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildCustomTextField(
                        controller: _dataEmissaoController,
                        label: 'Emissão',
                        placeholder: '[data_emp]',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Insira a data';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    _buildIconButton(
                      onPressed: () {
                        // Ação do primeiro botão azul
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Primeiro botão pressionado!'),
                            backgroundColor: Color(0xFF4FD1C7),
                          ),
                        );
                      },
                      icon: Icons.folder,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Campos Work Compensation e Validade com botão
                Row(
                  children: [
                    Expanded(
                      child: _buildCustomTextField(
                        controller: _workCompensationController,
                        label: 'Work Compensati...',
                        placeholder: '[work_compen]',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Insira os dados';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildCustomTextField(
                        controller: _validadeController,
                        label: 'Validade',
                        placeholder: '[data_workser]',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Insira a validade';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    _buildIconButton(
                      onPressed: () {
                        // Ação do segundo botão azul
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Segundo botão pressionado!'),
                            backgroundColor: Color(0xFF4FD1C7),
                          ),
                        );
                      },
                      icon: Icons.folder,
                    ),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),

      // Bottom Navigation Bar conforme a imagem
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Color(0xFF4FD1C7),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Botão Perfil (ativo)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFF4FD1C7),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Perfil',
                  style: TextStyle(
                    color: Color(0xFF4FD1C7),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            // Botão Home
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.home_outlined,
                  color: Colors.white.withOpacity(0.6),
                  size: 28,
                ),
                const SizedBox(height: 4),
                Text(
                  '',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Libera os recursos dos controladores quando o widget é destruído
  @override
  void dispose() {
    _nomeController.dispose();
    _enderecoController.dispose();
    _cidadeController.dispose();
    _cepController.dispose();
    _estadoController.dispose();
    _telefoneController.dispose();
    _empresaController.dispose();
    _cnpjController.dispose();
    _dataEmissaoController.dispose();
    _workCompensationController.dispose();
    _validadeController.dispose();
    super.dispose();
  }
}