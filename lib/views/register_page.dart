import 'package:flutter/material.dart';
import 'package:chat_app/components/auth_button.dart';
import 'package:chat_app/components/confirm_button.dart';
import 'package:chat_app/components/custom_input.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/utils/show_message.dart';
import 'package:chat_app/views/login_page.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.purple.shade300, 
      body: Padding(
        padding: const EdgeInsets.all(16.0), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.app_registration,
              size: 120,
              color: Colors.white, 
            ),
            const Text(
              'Cadastro',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black, 
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomInput(
              controller: nameController,
              labelText: 'Nome',
             
             
            ),
            CustomInput(
              controller: emailController,
              labelText: 'Email',
           
            ),
            CustomInput(
              controller: phoneController,
              labelText: 'Telefone',
          
            ),
            CustomInput(
              controller: passwordController,
              labelText: 'Senha',
              isObscure: true,
            
            ),
            CustomInput(
              controller: confirmController,
              labelText: 'Repita sua Senha',
              isObscure: true,
             
            ),
            const SizedBox(
              height: 20,
            ),
            ConfirmButton(
              onPressed: () async {
                try {
                  await FirebaseAuthService().register(
                    nameController.text,
                    phoneController.text,
                    emailController.text,
                    passwordController.text,
                  );

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                } catch (e) {
                  showMessage(context, e);
                }
              },
              labelText: 'Cadastrar',
            
            ),
          ],
        ),
      ),
    );
  }
}
