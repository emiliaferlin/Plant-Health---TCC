import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_health/src/shared/constantes.dart';
import 'package:plant_health/src/shared/style/textstyle.dart';

class LoginView extends StatefulWidget {
  final Function()? onTap;
  const LoginView({super.key, this.onTap});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  void logarSistema() async {
    if (formKey.currentState?.validate() == true) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: senhaController.text,
        );
      } on FirebaseAuthException catch (e) {
        // show errors messsages
        if (e.code == 'invalid-credential') {
          notificacaoGenerica('Credenciais inválidas, tente novamente!');
        } else if (e.code == 'invalid-email') {
          notificacaoGenerica('Informe um email válido!');
        } else if (e.code == 'user-not-found') {
          notificacaoGenerica('Email não encontrado, efetue o registro!');
        } else if (e.code == 'wrong-password') {
          notificacaoGenerica('Senha incorreta, tente novamente!');
        } else {
          // another error
          notificacaoGenerica(e.code);
        }
      }
    }
  }

  void notificacaoGenerica(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: primaryColor),
      backgroundColor: primaryColor,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100, child: Image.asset('image/logo.png')),
                SizedBox(height: 25),

                // MyTextField(
                //   controller: _emailController,
                //   hintText: 'Email',
                //   icon: Icon(Icons.email_outlined),
                //   obscureText: false,
                //   capitalization: false,
                // ),
                // SizedBox(height: 15),

                // MyTextField(
                //   controller: _passwordController,
                //   hintText: 'Senha',
                //   icon: Icon(Icons.lock_outline),
                //   obscureText: true,
                //   capitalization: false,
                // ),
                SizedBox(height: 15),

                // MyButton(
                //   onPressed: _handleSignIn,
                //   formKey: _formKey,
                //   text: 'Logar',
                // ),
                SizedBox(height: 20),

                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'Quero me cadastrar',
                    style: PlantTextStyle.bodySM(color: Colors.white),
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
