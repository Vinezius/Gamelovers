import 'package:flutter/material.dart';
import 'package:gamelovers/helpers/validar_email.dart';
import 'package:gamelovers/pages/cadastro_page.dart';
import 'package:gamelovers/pages/components/button.dart';
import 'package:gamelovers/pages/components/text_field.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void efetuarLogin(){

    _formKey.currentState!.validate();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 44, 44, 44),
      body: Form(
        key: _formKey,
        child: Center(
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
                validator: (senha) 
                {
                  if(senha!.isEmpty)
                  {
                    return 'Insira uma senha';
                  }
                  else if(senha.length < 6)
                  {
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
              const SizedBox(height: 25),
              
              CustomButton(
                onTap: efetuarLogin,
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
    );
  }
}
