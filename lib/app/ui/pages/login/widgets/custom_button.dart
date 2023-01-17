import 'package:flutter/material.dart';
import 'package:prueba_tecnica_dashfleet/app/controllers/controllers.dart';

class Custom_Button extends StatelessWidget {
  const Custom_Button({
    Key? key,
    required this.size,
    required LoginController loginController,
    required this.title,
  })  : _loginController = loginController,
        super(key: key);

  final Size size;
  final LoginController _loginController;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.002),
      height: size.height * 0.08,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(6)),
      child: TextButton(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(
                const Color.fromARGB(20, 255, 255, 255))),
        onPressed: () async {
          await _loginController.checkUserCredentials();
          await _loginController.logIn();
        },
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
