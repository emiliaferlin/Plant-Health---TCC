import 'package:flutter/material.dart';

class CardUmidadeArDashboard extends StatelessWidget {
  final double? value;
  const CardUmidadeArDashboard({this.value, super.key});

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
                  Icon(Icons.opacity, color: Color(0xFF42A5F5)),
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
