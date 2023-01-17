import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_tecnica_dashfleet/app/controllers/login_controller.dart';
import 'package:prueba_tecnica_dashfleet/app/controllers/nav_bar_controller.dart';
import 'package:prueba_tecnica_dashfleet/app/routes/routes.dart';
import 'package:prueba_tecnica_dashfleet/app/ui/widgets/widgets.dart';

class AppDrawer extends StatelessWidget {
  final LoginController _loginController =
      LoginController.initializeController();

  final NavBarController _navBarController =
      NavBarController.initializeController();

  final Size size;

  AppDrawer({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: size.width * 0.7,
        child: Container(
          margin: EdgeInsets.only(top: size.height * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: size.height * 0.025, right: size.height * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Menu",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.height * 0.045,
                              color: const Color.fromARGB(230, 0, 200, 73)),
                        ),
                        IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(
                              Icons.close,
                              color: Color.fromARGB(230, 0, 200, 73),
                            ))
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1.5,
                    color: Color.fromARGB(230, 0, 200, 73),
                  ),
                  buildTile(size, Icons.home_rounded, "Inicio", () {
                    _navBarController.changeTo(1);
                    return Get.toNamed(AppRoutes.HOME);
                  }),
                  buildTile(size, Icons.route_outlined, "Rutas", () {
                    _navBarController.changeTo(2);
                    return Get.toNamed(AppRoutes.ROADS);
                  })
                ],
              ),
              CustomButton(
                  margin: EdgeInsets.symmetric(
                      horizontal: size.height * 0.02,
                      vertical: size.height * 0.02),
                  label: "Cerrar sesión",
                  borderRadius: 10.0,
                  backgroundColor: const Color.fromARGB(230, 0, 200, 73),
                  labelStyle: TextStyle(
                      color: Colors.white, fontSize: size.height * 0.03),
                  onPressed: () => _loginController.logOut()),
            ],
          ),
        ));
  }

  Widget buildTile(
      Size size, IconData icon, String label, Function() onPressed) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.175),
      title: Text(
        label,
        style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: size.height * 0.034,
            color: const Color.fromARGB(230, 0, 200, 73)),
      ),
      leading: Icon(
        icon,
        color: const Color.fromARGB(230, 0, 200, 73),
        size: size.height * 0.05,
      ),
      onTap: onPressed,
    );
  }
}
