import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_health/src/components/campo_text/text_form_field_login.dart';
import 'package:plant_health/src/components/loading/loading.dart';
import 'package:plant_health/src/components/notification/notification.dart';
import 'package:plant_health/src/shared/constantes.dart';
import 'package:plant_health/src/shared/text_style/textstyle.dart';

class LoginView extends StatefulWidget {
  final Function()? onTap;
  const LoginView({super.key, this.onTap});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  static final FirebaseAuth _auth = FirebaseAuth.instance;

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
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 200, child: Image.asset('assets/logo.png')),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0, top: 50.0),
                    child: TextFormFieldLogin(
                      controller: emailController,
                      hintText: 'E-mail',
                      validator: (value) {
                        bool emailValid = false;
                        if (value != null) {
                          emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-_]+\.[a-zA-Z]+",
                          ).hasMatch(value);
                        }
                        if (value == null ||
                            value.isEmpty ||
                            emailValid == false) {
                          return "Insira um email valido";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: TextFormFieldLogin(
                      controller: senhaController,
                      hintText: 'Senha',
                      campoSenha: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Campo obrigatório";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: ElevatedButton(
                      onPressed: logarSistema,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: Size(double.infinity, 46.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        "Entrar",
                        style: PlantTextStyle.titleSM(color: Colors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      'Quero me cadastrar',
                      style: PlantTextStyle.bodyMD(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void logarSistema() async {
    if (formKey.currentState?.validate() == true) {
      try {
        LoadingPlant.requestLoader(true);
        await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: senhaController.text,
        );
        LoadingPlant.requestLoader(false);
      } on FirebaseAuthException catch (e) {
        LoadingPlant.requestLoader(false);
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
    NotificationPlant.warning(context, message: message);
  }
}
