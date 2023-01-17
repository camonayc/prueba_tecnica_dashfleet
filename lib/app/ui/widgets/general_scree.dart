import 'package:flutter/material.dart';
import 'package:prueba_tecnica_dashfleet/app/data/models/user.dart';

class GeneralScreen extends StatelessWidget {
  const GeneralScreen({
    Key? key,
    required this.size,
    required this.scaffoldKey,
    required this.containScreen,
    required this.user,
  }) : super(key: key);

  final Size size;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Widget containScreen;
  final Users user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.2,
              width: size.width,
              color: const Color.fromARGB(230, 0, 200, 73),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: size.height * 0.05,
                          left: size.height * 0.02,
                          right: size.height * 0.035),
                      height: size.height * 0.12,
                      width: size.height * 0.12,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                          image: user.data?.picture != null ? DecorationImage(
                              image: NetworkImage("${user.data?.picture}")): null)),
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.02),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width * 0.45,
                          child: Text(
                            "${user.data?.name} ${user.data?.lastName}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: size.height * 0.035,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: size.height * 0.01)),
                        Text("${user.data?.phone}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: size.height * 0.028)),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: size.height * 0.057, left: size.height * 0.05),
                    child: IconButton(
                        onPressed: () =>
                            scaffoldKey.currentState!.openEndDrawer(),
                        icon: Icon(
                          Icons.reorder_outlined,
                          size: size.height * 0.072,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ),
            containScreen
          ],
        ),
      ),
    );
  }
}
