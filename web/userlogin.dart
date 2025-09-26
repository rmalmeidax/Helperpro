import 'package:flutter/material.dart';
import 'FrmPrincipalWidget.dart';

class FrmLoginWidget extends StatefulWidget {
  final String title;
  const FrmLoginWidget({super.key, required this.title});

  @override
  State<FrmLoginWidget> createState() => _FrmLoginWidgetState();
}

class _FrmLoginWidgetState extends State<FrmLoginWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisible = false;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
            height: size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/login_bg@2x.png'),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Image.asset(
                  'assets/esespro.jpeg',
                  width: 170,
                  height: 66,
                ),
                const SizedBox(height: 20),

                  // Título
                Center(
                  child: Text(
                    'Welcome Helper Pro',
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    ),
                  ),
                  const SizedBox(height: 16),

                // Subtítulo
                Text(
                  'Log in to access your account.',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),

                // Campo Email
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Your email',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 12),

                // Campo Senha
                TextFormField(
                  controller: passwordController,
                  obscureText: !passwordVisible,
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
                            : Icons.visibility_off_outlined,
                        color: Colors.lightBlue,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 24),

                // Linha com "Forgot password?" e botão Access
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        // TODO: Navegar para tela de recuperação de senha
                      },
                      child: const Text(
                        'Forgot your password?',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
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
                          // TODO: autenticação real

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const FrmPrincipalWidget()),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $e')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Access',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Criar conta
                Center(
                  child: InkWell(
                    onTap: () {
                      // TODO: Navegar para tela de registro
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
                            'Do you have an account? ',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                          Text(
                            'Create account',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FrmPrincipalWidget(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.3),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Stay as a visitor',
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
