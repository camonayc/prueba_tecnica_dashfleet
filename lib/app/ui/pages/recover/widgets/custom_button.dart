import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_tecnica_dashfleet/app/controllers/controllers.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.size,
    required Function() onPressed,
    required this.title,
    required this.margin,
  })  : _onPressed = onPressed,
        super(key: key);

  final Size size;
  final Function() _onPressed;
  final String title;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: size.height * 0.08,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(6)),
      child: TextButton(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(
                const Color.fromARGB(20, 255, 255, 255))),
        onPressed: _onPressed,
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: size.height * 0.26 * 1 / 8),
        ),
      ),
    );
  }
}
