import 'package:flutter/material.dart';

class ContainHomeScreen extends StatelessWidget {
  const ContainHomeScreen({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: size.height * 0.03),
          child: Text(
            "PAGINA DE INICIO",
            style: TextStyle(
              fontSize: size.height * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
