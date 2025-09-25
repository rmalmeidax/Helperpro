import 'package:flutter/material.dart';

class FrmRecuperaSenhaWidget extends StatefulWidget {
  const FrmRecuperaSenhaWidget({super.key});

  @override
  State<FrmRecuperaSenhaWidget> createState() =>
      _FrmRecuperaSenhaWidgetState();
}

class _FrmRecuperaSenhaWidgetState extends State<FrmRecuperaSenhaWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _mostrarSnackBar(String mensagem, Color cor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem), backgroundColor: cor),
    );
  }

  void _enviarRecuperacao() {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      _mostrarSnackBar('Por favor, digite seu email', Colors.red);
      return;
    }

    // Validação básica de email
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      _mostrarSnackBar('Por favor, digite um email válido', Colors.red);
      return;
    }

    // Aqui você implementaria a lógica real de envio de email
    _mostrarSnackBar(
        'Email de recuperação enviado! Verifique sua caixa de entrada.',
        Colors.green);

    // Voltar automaticamente para a tela de login após 2 segundos
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height - MediaQuery.of(context).padding.top,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Botão Voltar
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 20),

                // Logo
                Image.asset(
                  'assets/esespro.jpeg',
                  width: 170,
                  height: 66,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 170,
                      height: 66,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                        size: 40,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),

                // Título
                Text(
                  'Recuperar Senha',
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),

                // Subtítulo
                Text(
                  'Digite seu email para receber as instruções de recuperação de senha.',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 40),

                // Campo Email
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _enviarRecuperacao(),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Digite seu email',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.lightBlue,
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 40),

                // Botão Enviar
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _enviarRecuperacao,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Enviar Email de Recuperação',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Link voltar ao login
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Voltar ao Login',
                      style: TextStyle(
                        color: Colors.black87,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
