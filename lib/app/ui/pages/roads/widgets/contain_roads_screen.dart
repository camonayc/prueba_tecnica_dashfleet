import 'package:flutter/material.dart';
import 'package:prueba_tecnica_dashfleet/app/data/models/user.dart';
import 'package:prueba_tecnica_dashfleet/app/ui/pages/roads/widgets/widgets.dart';

class ContainRoadsScreen extends StatelessWidget {
  ContainRoadsScreen({
    Key? key,
    required this.size,
    required this.user,
  }) : super(key: key);

  final Size size;
  final Users user;

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [];
    if (user.data!.routes != null && user.data!.routes != []) {
      for (var i = 0; i < user.data!.routes!.length; i++) {
        cards.add(CardRoutes(size: size, route: user.data!.routes![i]!));
        cards.add(Padding(padding: EdgeInsets.only(top: size.height * 0.03)));
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: size.height * 0.03,
                bottom: size.height * 0.03,
              ),
              child: Text(
                "PAGINA DE RUTAS",
                style: TextStyle(
                    fontSize: size.height * 0.04, fontWeight: FontWeight.bold),
              ),
            ),
          ] +
          cards,
    );
  }
}
