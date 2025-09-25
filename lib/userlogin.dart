import 'package:flutter/material.dart';

import 'FrmPrincipalWidget.dart';

// Widget principal da tela de login
class FrmLoginWidget extends StatefulWidget {
  final String title;
  const FrmLoginWidget({super.key, required this.title});

  @override
  State<FrmLoginWidget> createState() => _FrmLoginWidgetState();
}
  // Nome e caminho da rota (usado para navegação)
  String routeName = 'FrmLogin';
  String routePath = '/frmLogin';

  @override
  State<FrmLoginWidget> createState() => _FrmLoginWidgetState();


// Estado do widget (a parte que guarda os dados e controla a interface)
class _FrmLoginWidgetState extends State<FrmLoginWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>(); // Chave para o Scaffold, caso precise controlar snackbars ou Drawer

  // Controladores de texto para os campos de email e senha
  late TextEditingController emailController;
  late TextEditingController passwordController;

  // Controle de visibilidade da senha
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    // Inicializa os controladores e a visibilidade da senha
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisible = false;
  }

  @override
  void dispose() {
    // Descarta os controladores ao sair da tela para liberar memória
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Pega o tema atual da aplicação
    final size = MediaQuery.of(context).size; // Pega o tamanho da tela

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white, // Cor de fundo
      body: SafeArea(
        child: SingleChildScrollView( // Permite rolar a tela se a altura for menor que a tela
          child: Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/login_bg@2x.png'), // Imagem de fundo
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40), // Espaçamento interno
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo do app
                Image.asset(
                  'assets/esespro.jpeg',
                  width: 170,
                  height: 66,
                ),
                const SizedBox(height: 20), // Espaço
                // Título da tela
                Text(
                  'Welcome Helper Pro',
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white10,
                  ),
                ),
                const SizedBox(height: 12),
                // Subtítulo ou instrução
                Text(
                  'Log in to access your account.',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                // Campo de email
                TextFormField(
                  controller: emailController, // Controlador do campo
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Your email',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1), // Fundo do campo semi-transparente
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none, // Sem borda
                    ),
                  ),
                  style: const TextStyle(color: Colors.white), // Texto branco
                ),
                const SizedBox(height: 12),
                // Campo de senha
                TextFormField(
                  controller: passwordController,
                  obscureText: !passwordVisible, // Oculta o texto se passwordVisible = false
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Your password....',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined, // Ícone de olho
                        color: Colors.lightBlue,
                      ),
                      onPressed: () {
                        // Alterna visibilidade da senha
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 24),
                // Linha com botão "Esqueceu sua senha?" e "Acesso"
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Botão texto para recuperação de senha
                    TextButton(
                      onPressed: () {
                        // Aqui você colocaria a navegação para tela de recuperação de senha
                      },
                      child: const Text(
                        'Forgot your password?',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                    // Botão de login
            ElevatedButton(
              onPressed: () {
                final email = emailController.text;
                final senha = passwordController.text;

                if (email.isEmpty || senha.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Fill in the empty fields'),
                    ),
                  );
                  return;
                }

                try {
                  // TODO: Autenticar com banco de dados
                  // Você pode implementar a validação aqui

                  // Login realizado - navegar para tela principal
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => FrmPrincipalWidget()),
                  );
                } catch (e) {
                  // Mostrar erro caso falhe
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro: $e')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Acesso'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Criar conta
                Center(
                  child: InkWell(
                    onTap: () {
                      // Aqui você colocaria a navegação para registro
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Do you have an account?',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                          Text(
                            'To create',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.blueAccent,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Continuar como visitante
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // ação de continuar como visitante
                      Navigator.pushReplacement
                        (context, MaterialPageRoute(builder:
                      (context) => const FrmPrincipalWidget(),
                      ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.1),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text(
                      'Continue as a visitor',
                      style: TextStyle(color: Colors.black87),
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

