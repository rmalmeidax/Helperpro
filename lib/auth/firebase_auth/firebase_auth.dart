import 'package:firebase_auth/firebase_auth.dart';

// Instância global do FirebaseAuth
final FirebaseAuth _auth = FirebaseAuth.instance;

// Retorna o usuário atual (ou null se não logado)
User? get currentUser => _auth.currentUser;

// Login com email e senha
Future<User?> signInWithEmail(String email, String password) async {
  try {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  } catch (e) {
    print("Erro no login: $e");
    return null;
  }
}

// Registro de novo usuário
Future<User?> registerWithEmail(String email, String password) async {
  try {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  } catch (e) {
    print("Erro no registro: $e");
    return null;
  }
}

// Logout
Future<void> signOut() async {
  await _auth.signOut();
}
