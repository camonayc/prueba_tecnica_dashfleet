import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_tecnica_dashfleet/app/controllers/session_controller.dart';
import 'package:prueba_tecnica_dashfleet/app/data/models/user.dart';
import 'package:prueba_tecnica_dashfleet/app/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  static LoginController initializeController() {
    try {
      LoginController controller = Get.find<LoginController>();
      return controller;
    } catch (e) {
      LoginController controller = Get.put(LoginController());
      return controller;
    }
  }

  SessionController splashController = SessionController.initializeController();

  RxBool isLoading = false.obs;

  RxBool checkPhone = false.obs;
  RxBool checkPassword = false.obs;

  Rx<ValueNotifier<bool>> remember = ValueNotifier<bool>(false).obs;

  RxString phone = "".obs;
  RxString password = "".obs;

  String? findErrorMessage(String key) {
    if (phone.value.length < 10 && phone.value.isNotEmpty) {
      return "Numero erroneo";
    } else {
      return null;
    }
  }

  checkUserCredentials() {
    for (var user in splashController.users) {
      if (phone.value == user.data?.phone && password.value == user.data?.password) {
        checkPhone.value = true;
        checkPassword.value = true;
        splashController.currentUser.value = user;
      }
    }
  }

  logIn() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    if (checkPhone.value == true && checkPassword.value == true) {
      await Future.delayed(const Duration(seconds: 2));
      if (remember.value.value == true) {
        prefs.setString('userPhone', phone.value);
        prefs.setString('userPassword', password.value);
      }
      if (remember.value.value == false) {
        prefs.setString('userPhone', "");
        prefs.setString('userPassword', "");
      }
      Get.offAllNamed(AppRoutes.HOME);
      isLoading.value = false;
    } else {
      if (checkPhone.value == false || checkPassword.value == false) {
        await Future.delayed(const Duration(seconds: 2));
        isLoading.value = false;
        Get.defaultDialog(
            title: "No se pudo iniciar sesión",
            middleText: "Número de celular o clave incorrectos");
      }
    }
  }

  redirectUser() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offAllNamed(AppRoutes.HOME);
  }

  logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userPhone', "");
    prefs.setString('userPassword', "");
    splashController.currentUser.value = Users();
    phone.value = "";
    password.value = "";
    checkPhone.value = false;
    checkPassword.value = false;
    remember.value.value = false;
    await Future.delayed(const Duration(seconds: 2));
    Get.offAllNamed(AppRoutes.LOGIN);
  }
}
