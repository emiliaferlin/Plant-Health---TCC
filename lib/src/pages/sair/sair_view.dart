import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SairView extends StatefulWidget {
  const SairView({super.key});

  @override
  State<SairView> createState() => _SairViewState();
}

class _SairViewState extends State<SairView> {
  @override
  void initState() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.signOut();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
