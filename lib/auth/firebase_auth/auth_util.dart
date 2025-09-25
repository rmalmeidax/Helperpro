import 'package:firebase_auth/firebase_auth.dart';

/// Registrar usuário com email e senha
Future<User?> registerWithEmail(String email, String password) async {
  try {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return credential.user;
  } on FirebaseAuthException catch (e) {
    print('Erro ao registrar: ${e.code} - ${e.message}');
    return null;
  } catch (e) {
    print('Erro inesperado: $e');
    return null;
  }
}

/// Login anônimo
Future<User?> signInAnonymously() async {
  try {
    final credential = await FirebaseAuth.instance.signInAnonymously();
    return credential.user;
  } on FirebaseAuthException catch (e) {
    print('Erro login anônimo: ${e.code} - ${e.message}');
    return null;
  } catch (e) {
    print('Erro inesperado: $e');
    return null;
  }
}
