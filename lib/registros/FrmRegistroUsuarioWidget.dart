import 'package:flutter/material.dart';
import 'FrmPrincipalWidget.dart';


class FrmRegistroUsuarioWidget extends StatefulWidget {
  const FrmRegistroUsuarioWidget({super.key});

  @override
  State<FrmRegistroUsuarioWidget> createState() =>
      _FrmRegistroUsuarioWidgetState();
}

class _FrmRegistroUsuarioWidgetState extends State<FrmRegistroUsuarioWidget> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();
  bool senhaVisivel = false;

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Criar sua conta',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Preencha os dados abaixo para continuar.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),
              // Campo Nome
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome completo',
                  hintText: 'Digite seu nome',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              // Campo Email
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Digite seu email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16),
              // Campo Senha
              TextField(
                controller: senhaController,
                obscureText: !senhaVisivel,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Digite sua senha',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      senhaVisivel ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        senhaVisivel = !senhaVisivel;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Campo Confirmar Senha
              TextField(
                controller: confirmarSenhaController,
                obscureText: !senhaVisivel,
                decoration: const InputDecoration(
                  labelText: 'Confirmar Senha',
                  hintText: 'Repita sua senha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 30),
              // Botão Registrar
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    final nome = nomeController.text.trim();
                    final email = emailController.text.trim();
                    final senha = senhaController.text;
                    final confirmarSenha = confirmarSenhaController.text;

                    if (nome.isEmpty ||
                        email.isEmpty ||
                        senha.isEmpty ||
                        confirmarSenha.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Preencha todos os campos')),
                      );
                      return;
                    }

                    if (senha != confirmarSenha) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('As senhas não coincidem')),
                      );
                      return;
                    }

                    if (senha.length < 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                            Text('A senha deve ter pelo menos 6 caracteres')),
                      );
                      return;
                    }

                    // Sucesso
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Conta criada com sucesso!'),
                        backgroundColor: Colors.green,
                      ),
                    );

                    // Vai para tela principal
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  FrmPrincipalWidget()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    'Criar Conta',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Link para voltar ao login
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Já tem uma conta? Fazer login',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}