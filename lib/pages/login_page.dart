import 'package:flutter/material.dart';
import 'package:gamelovers/helpers/validar_email.dart';
import 'package:gamelovers/pages/cadastro_page.dart';
import 'package:gamelovers/pages/components/button.dart';
import 'package:gamelovers/pages/components/text_field.dart';
import 'package:gamelovers/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamelovers/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final User? user = Auth().currentUser;
  bool isLogin = true;
  String? errorMessage;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Future<bool> efetuarLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: senhaController.text.trim(),
        );
        return true;
      } on FirebaseAuthException catch (e) {
        setState(() {
          errorMessage = e.message;
        });
        return false;
      }
    }
    return false;
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
                  'Seja bem vindo ao Gamelovers!',
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w900),
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
                    if(senha!.isEmpty) {
                      return 'Insira uma senha';
                    } else if(senha.length < 6) {
                      return 'A senha deve ter no mínimo 6 caracteres';
                    }
                    return null;
                  },
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Esqueceu a senha?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  )
                ),
                if(errorMessage != null)
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 25),
                
                CustomButton(
                  onTap: () async {
                    bool resultValidation = await efetuarLogin();
                    if(resultValidation) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    }
                  },
                ),
                const SizedBox(height: 10),
                CustomButton(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => CadastroPage()),
                    );
                  },
                  textoBotao: 'Criar conta',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
