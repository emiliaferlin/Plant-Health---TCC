import 'package:flutter/material.dart';

class CardUmidadeSolo extends StatelessWidget {
  final double? value;
  const CardUmidadeSolo({this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.grass, color: Color(0xFF6D4C41)),
                  SizedBox(width: 8),
                  Text(
                    '$value%',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
