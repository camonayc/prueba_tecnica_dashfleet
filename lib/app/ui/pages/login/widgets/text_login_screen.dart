import 'package:flutter/material.dart';

class LoginText extends StatelessWidget {
  const LoginText({
    Key? key,
    required this.title,
    required this.size,
  }) : super(key: key);

  final Size size;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: size.height * 0.26 * 1 / 6),
    );
  }
}
