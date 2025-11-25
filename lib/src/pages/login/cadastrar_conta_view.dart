import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_health/src/components/campo_text/text_form_field_login.dart';
import 'package:plant_health/src/components/loading/loading.dart';
import 'package:plant_health/src/components/notification/notification.dart';
import 'package:plant_health/src/shared/constantes.dart';
import 'package:plant_health/src/shared/text_style/textstyle.dart';

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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nomeText = TextEditingController();
  TextEditingController emailText = TextEditingController();
  TextEditingController senhaText = TextEditingController();
  TextEditingController confirmaSenhaText = TextEditingController();

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
      resizeToAvoidBottomInset: true,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    child: ClipOval(child: Image.asset('assets/logo.png')),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Por favor, preenchar os seus dados para continuar. ',
                    style: PlantTextStyle.bodyLG(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25),
                  TextFormFieldLogin(
                    controller: nomeText,
                    hintText: 'Nome completo',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormFieldLogin(
                    controller: emailText,
                    hintText: 'Email',
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
                  SizedBox(height: 16.0),
                  TextFormFieldLogin(
                    controller: senhaText,
                    hintText: 'Senha',
                    campoSenha: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormFieldLogin(
                    controller: confirmaSenhaText,
                    hintText: 'Confirmar senha',
                    campoSenha: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: registrarConta,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: Size(double.infinity, 46.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      "Registrar",
                      style: PlantTextStyle.titleSM(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Já possui uma conta? ',
                        style: PlantTextStyle.bodyMD(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Faça login.',
                          style: PlantTextStyle.bodyMD(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void registrarConta() async {
    if (formKey.currentState?.validate() == true) {
      try {
        LoadingPlant.requestLoader(true);
        // check if both password and confirm password is same
        if (senhaText.text == confirmaSenhaText.text) {
          UserCredential userCredential = await _auth
              .createUserWithEmailAndPassword(
                email: emailText.text.trim(),
                password: senhaText.text,
              );

          // save to users collection
          final CollectionReference _users = FirebaseFirestore.instance
              .collection('users');
          LoadingPlant.requestLoader(false);
          await _users.doc(userCredential.user!.uid).set({
            'uid': userCredential.user!.uid,
            'displayName': nomeText.text.trim(),
            'email': emailText.text.trim(),
            'photoURL':
                'https://ui-avatars.com/api/?name=${nomeText.text}&background=E01C2F&color=fff',
          });
          LoadingPlant.requestLoader(false);
          // go to home screen
        } else {
          LoadingPlant.requestLoader(false);
          genericErrorMessage("As senhas não correspondem!");
        }
        LoadingPlant.requestLoader(false);
      } on FirebaseAuthException catch (e) {
        LoadingPlant.requestLoader(false);
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
  }

  void genericErrorMessage(String message) {
    NotificationPlant.warning(context, message: message);
  }
}
