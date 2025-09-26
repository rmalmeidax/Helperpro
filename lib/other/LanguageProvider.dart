// language_provider.dart
import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  String _currentLanguage = 'BR';

  String get currentLanguage => _currentLanguage;

  final Map<String, Map<String, String>> _translations = {
    'BR': {
      // Títulos principais
      'app_title': 'Helper Pro',
      'welcome_title': 'Bem-vindo Helper Pro',
      'login_subtitle': 'Faça login para acessar sua conta.',

      // Campos de formulário
      'email_label': 'Email',
      'email_hint': 'Seu email',
      'password_label': 'Senha',
      'password_hint': 'Sua senha....',

      // Botões e ações
      'access_button': 'Acessar',
      'forgot_password': 'Esqueceu sua senha?',
      'create_account_question': 'Não tem uma conta? ',
      'create_account_link': 'Criar conta',
      'stay_visitor': 'Continuar como visitante',

      // Mensagens de validação
      'empty_fields_error': 'Preencha os campos vazios',
      'error_prefix': 'Erro: ',

      // Idiomas
      'language_en': 'Inglês',
      'language_br': 'Português',
      'language_es': 'Espanhol',
    },
    'EN': {
      // Main titles
      'app_title': 'Helper Pro',
      'welcome_title': 'Welcome Helper Pro',
      'login_subtitle': 'Log in to access your account.',

      // Form fields
      'email_label': 'Email',
      'email_hint': 'Your email',
      'password_label': 'Password',
      'password_hint': 'Your password....',

      // Buttons and actions
      'access_button': 'Access',
      'forgot_password': 'Forgot your password?',
      'create_account_question': 'Don\'t have an account? ',
      'create_account_link': 'Create account',
      'stay_visitor': 'Stay as a visitor',

      // Validation messages
      'empty_fields_error': 'Fill in the empty fields',
      'error_prefix': 'Error: ',

      // Languages
      'language_en': 'English',
      'language_br': 'Portuguese',
      'language_es': 'Spanish',
    },
    'ES': {
      // Títulos principales
      'app_title': 'Helper Pro',
      'welcome_title': 'Bienvenido Helper Pro',
      'login_subtitle': 'Inicia sesión para acceder a tu cuenta.',

      // Campos de formulario
      'email_label': 'Email',
      'email_hint': 'Tu email',
      'password_label': 'Contraseña',
      'password_hint': 'Tu contraseña....',

      // Botones y acciones
      'access_button': 'Acceder',
      'forgot_password': '¿Olvidaste tu contraseña?',
      'create_account_question': '¿No tienes una cuenta? ',
      'create_account_link': 'Crear cuenta',
      'stay_visitor': 'Continuar como visitante',

      // Mensajes de validación
      'empty_fields_error': 'Completa los campos vacíos',
      'error_prefix': 'Error: ',

      // Idiomas
      'language_en': 'Inglés',
      'language_br': 'Portugués',
      'language_es': 'Español',
    },
  };

  Map<String, Map<String, String>> get translations => _translations;

  void changeLanguage(String languageCode) {
    if (_translations.containsKey(languageCode)) {
      _currentLanguage = languageCode;
      notifyListeners();
    }
  }

  String translate(String key) {
    return _translations[_currentLanguage]?[key] ?? key;
  }
}