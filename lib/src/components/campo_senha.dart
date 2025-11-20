import 'package:flutter/material.dart';

class CampoSenha extends StatelessWidget {
  final TextEditingController? controller;
  const CampoSenha({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "E-mail",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
