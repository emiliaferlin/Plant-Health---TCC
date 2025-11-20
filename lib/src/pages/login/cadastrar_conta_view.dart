import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_health/src/shared/constantes.dart';

class CadastrarContaView extends StatefulWidget {
  final Function()? onTap;
  const CadastrarContaView({super.key, required this.onTap});

  @override
  State<CadastrarContaView> createState() {
    return CadastrarContaViewState();
  }
}

class CadastrarContaViewState extends State<CadastrarContaView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _handleSignUp() async {
    try {
      // check if both password and confirm password is same
      if (_passwordController.text == _confirmPasswordController.text) {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text,
            );

        // save to users collection
        final CollectionReference _users = FirebaseFirestore.instance
            .collection('users');
        await _users.doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'displayName': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'photoURL':
              'https://ui-avatars.com/api/?name=${_nameController.text}&background=E01C2F&color=fff',
        });
        // go to home screen
      } else {
        genericErrorMessage("As senhas não correspondem!");
      }
    } on FirebaseAuthException catch (e) {
      // show errors messsages
      if (e.code == 'weak-password') {
        genericErrorMessage('A senha é muito fraca, tente novamente!');
      } else if (e.code == 'invalid-email') {
        genericErrorMessage('Informe um email válido!');
      } else if (e.code == 'email-already-in-use') {
        genericErrorMessage('Email já cadastrado, efetue o login!');
      } else {
        // another error
        genericErrorMessage(e.code);
      }
    }
  }

  void genericErrorMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: primaryColor),
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                SizedBox(
                  height: 100,
                  child: ClipOval(child: Image.asset('assets/logo.png')),
                ),
                SizedBox(height: 10),
                Text(
                  'Por favor, preenchar os seus dados para continuar. ',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                SizedBox(height: 25),

                // MyTextField(
                //   controller: _nameController,
                //   hintText: 'Nome completo',
                //   icon: Icon(Icons.person_outline),
                //   obscureText: false,
                //   capitalization: true,
                // ),
                SizedBox(height: 15),

                // MyTextField(
                //   controller: _emailController,
                //   hintText: 'Email',
                //   icon: Icon(Icons.email_outlined),
                //   obscureText: false,
                //   capitalization: false,
                // ),
                SizedBox(height: 15),

                // MyTextField(
                //   controller: _passwordController,
                //   hintText: 'Senha',
                //   icon: Icon(Icons.lock_outline),
                //   obscureText: true,
                //   capitalization: false,
                // ),
                SizedBox(height: 15),

                // MyTextField(
                //   controller: _confirmPasswordController,
                //   hintText: 'Confirmar senha',
                //   icon: Icon(Icons.shield_outlined),
                //   obscureText: true,
                //   capitalization: false,
                // ),
                SizedBox(height: 15),

                // MyButton(
                //   onPressed: _handleSignUp,
                //   formKey: _formKey,
                //   text: 'Registrar',
                // ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Já possui uma conta? ',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Faça login',
                        style: TextStyle(
                          color: Color(0xffE01C2F),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
