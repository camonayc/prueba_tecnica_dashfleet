import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_tecnica_dashfleet/app/controllers/session_controller.dart';
import 'package:prueba_tecnica_dashfleet/app/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  final SessionController _splashController =
      SessionController.initializeController();

  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _splashController.loadUsersData();
    redirect();
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: size.height,
      width: size.width,
      color: const Color.fromARGB(230, 0, 200, 73),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: const Text(
                "Bienvenido",
                style: TextStyle(color: Colors.white, fontSize: 30),
              )),
          Container(
            decoration: BoxDecoration(border: Border.all(width: 0.1)),
            width: size.width * 0.5,
            child: const LinearProgressIndicator(
                minHeight: 3,
                backgroundColor: Colors.white,
                color: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green)),
          ),
        ],
      ),
    ));
  }

  redirect() async {
    await Future.delayed(const Duration(seconds: 2));
    if (_splashController.dateLoading.value == true) {
      await _splashController.rememberUser();
      if (_splashController.isRememberUser.value == true) {
        Get.offAllNamed(AppRoutes.HOME);
      } else {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('userPhone', "");
        prefs.setString('userPassword', "");
        Get.offAllNamed(AppRoutes.LOGIN);
      }
    } else {
      Get.offAllNamed(AppRoutes.LOGIN);
    }
  }
}
