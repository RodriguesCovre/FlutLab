import 'package:chat_app/components/auth_button.dart';
import 'package:chat_app/components/confirm_button.dart';
import 'package:chat_app/components/custom_input.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/views/home_page.dart';
import 'package:chat_app/views/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade300, Colors.purple.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.message_outlined,
                size: 100,
                color: Colors.white,
              ),
              const SizedBox(height: 20),
              const Text(
                "Bem-vindo de volta!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Faça login para continuar",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 40),
              CustomInput(
                controller: emailController,
                labelText: 'Email',
                
              ),
              const SizedBox(height: 20),
              CustomInput(
                controller: passwordController,
                labelText: 'Password',
                isObscure: true,
                
              ),
              const SizedBox(height: 30),
              ConfirmButton(
                labelText: 'Entrar',
                onPressed: () async {
                  try {
                    var user = await FirebaseAuthService().login(
                        emailController.text, passwordController.text);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          e.toString(),
                        ),
                      ),
                    );
                  }
                },
                // backgroundColor: Colors.white.withOpacity(0.3),
                // textStyle: const TextStyle(
                //   color: Colors.white,
                //   fontWeight: FontWeight.bold,
                // ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Ainda não tem uma conta?',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Inscreva-se',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.white54),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthButton(
                    image:
                        'https://cdn-icons-png.flaticon.com/512/2702/2702602.png',
                  ),
                  const SizedBox(width: 20),
                  AuthButton(
                    image:
                        'https://static.vecteezy.com/system/resources/previews/016/716/481/original/facebook-icon-free-png.png',
                  ),
                  const SizedBox(width: 20),
                  AuthButton(
                    image:
                        'https://cdn-icons-png.flaticon.com/512/25/25231.png',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
