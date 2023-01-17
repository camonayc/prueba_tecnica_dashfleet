

import 'package:flutter/material.dart';
import 'package:prueba_tecnica_dashfleet/app/data/models/user.dart' as u;

class CardRoutes extends StatelessWidget {
  const CardRoutes({
    Key? key,
    required this.size,
    required this.route,
  }) : super(key: key);

  final Size size;
  final u.Route route;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.12,
      margin: EdgeInsets.symmetric(horizontal: size.height * 0.04),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: size.height * 0.1,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 0.5),
                borderRadius: BorderRadius.circular(10),
                image:
                    DecorationImage(image: NetworkImage("${route.picture}"))),
            margin: EdgeInsets.symmetric(
                horizontal: size.height * 0.03, vertical: size.height * 0.02),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${route.name}",
                  style: TextStyle(
                      fontSize: size.height * 0.03,
                      fontWeight: FontWeight.bold),
                ),
                Padding(padding: EdgeInsets.only(top: size.height * 0.01)),
                Text(
                  "${route.distances} Kilometros.",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: size.height * 0.024,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
