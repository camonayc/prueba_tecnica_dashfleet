import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_tecnica_dashfleet/app/controllers/nav_bar_controller.dart';
import 'package:prueba_tecnica_dashfleet/app/routes/routes.dart';

class AppNavBar extends StatelessWidget {
  final NavBarController _navBarController =
      NavBarController.initializeController();

  AppNavBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  static Map<int, dynamic> routesMap = {
    1: AppRoutes.HOME,
    2: AppRoutes.ROADS,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.1,
      width: size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
                  color: Color.fromARGB(230, 0, 200, 73), width: 5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildNavBarItem(
              icon: Icons.home_rounded,
              index: 1,
              onPressed: () => navigateTo(1),
              size: size),
          Padding(padding: EdgeInsets.only(left: size.width * 0.2)),
          buildNavBarItem(
              icon: Icons.route_outlined,
              index: 2,
              onPressed: () => navigateTo(2),
              size: size),
        ],
      ),
    );
  }

  void navigateTo(int route) {
    if (routesMap[route] != Get.currentRoute) {
      _navBarController.changeTo(route);
      Get.offAndToNamed(routesMap[route]);
    }
  }

  Widget buildNavBarItem(
      {required Size size,
      required IconData icon,
      required int index,
      required Function() onPressed}) {
    return Obx(() {
      return Container(
        margin: EdgeInsets.only(bottom: size.height * 0.015),
        child: IconButton(
            splashRadius: 5,
            onPressed: onPressed,
            icon: Icon(icon,
                size: size.height * 0.06,
                color: _navBarController.currentIndex.value == index
                    ? const Color.fromARGB(230, 0, 200, 73)
                    : Colors.black)),
      );
    });
  }
}
