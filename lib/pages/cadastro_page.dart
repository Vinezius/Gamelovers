import 'package:flutter/material.dart';
import 'package:gamelovers/helpers/validar_email.dart';
import 'package:gamelovers/pages/components/button.dart';
import 'package:gamelovers/pages/components/text_field.dart';
import 'package:gamelovers/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamelovers/auth.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> efetuarCadastro() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: senhaController.text.trim(),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } catch (e) {
        if (e is FirebaseAuthException) {
          if (e.code == 'weak-password') {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Senha Fraca'),
                  content: Text('A senha fornecida é muito fraca.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          } else if (e.code == 'email-already-in-use') {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Email Já Em Uso'),
                  content: const Text('O email fornecido já está em uso por outra conta.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 44, 44, 44),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Faça seu cadastro!',
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  controller: nomeController,
                  hintText: 'Nome',
                  obscureText: false,
                  validator: (nome) {
                    if (nome!.isEmpty) {
                      return 'Insira um nome';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  controller: emailController,
                  hintText: 'E-mail',
                  obscureText: false,
                  validator: (value) {
                    return validateEmail(value);
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: senhaController,
                  hintText: 'Senha',
                  obscureText: true,
                  validator: (senha) {
                    if (senha!.isEmpty) {
                      return 'Insira uma senha';
                    } else if (senha.length < 6) {
                      return 'A senha deve ter no mínimo 6 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                CustomButton(
                  onTap: efetuarCadastro,
                  textoBotao: 'Cadastrar',
                ),
                const SizedBox(height: 10),
                CustomButton(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  textoBotao: 'Voltar para o login',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
