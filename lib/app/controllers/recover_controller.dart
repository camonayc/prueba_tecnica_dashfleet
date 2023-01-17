import 'dart:developer';

import 'package:get/get.dart';
import 'package:prueba_tecnica_dashfleet/app/controllers/controllers.dart';
import 'package:prueba_tecnica_dashfleet/app/data/models/models.dart';
import 'package:prueba_tecnica_dashfleet/app/data/services/firebase_service.dart';
import 'package:prueba_tecnica_dashfleet/app/routes/routes.dart';

class RecoverController extends GetxController {
  static RecoverController initializeController() {
    try {
      RecoverController controller = Get.find<RecoverController>();
      return controller;
    } catch (e) {
      RecoverController controller = Get.put(RecoverController());
      return controller;
    }
  }

  SessionController sessionController =
      SessionController.initializeController();

  RxString newPassword = "".obs;
  RxString confirmNewPassword = "".obs;
  RxString phone = "".obs;
  Rx<Users> userCheck = Users().obs;
  RxInt indexUserCheck = 0.obs;

  RxBool isTherePhone = false.obs;
  RxBool isThereNewPassword = false.obs;
  RxBool isThereConfirmPassword = false.obs;

  RxBool isUserCheck = false.obs;
  RxBool isRighBothPassword = false.obs;
  RxBool isLoading = false.obs;

  checkUser() async {
    sessionController.loadUsersData();
    final users = sessionController.users;
    for (var i = 0; i < users.length; i++) {
      if (phone.value == users[i].data?.phone) {
        userCheck.value = users[i];
        indexUserCheck.value = i;
        isUserCheck.value = true;
      }
    }
    if (isUserCheck.value == true) {
      log('Usuario confirmado');
    }
    if (isUserCheck.value == false) {
      log('Usuario no existente');
    }
  }

  checkPassword() {
    if (newPassword.value != "" && confirmNewPassword.value != "") {
      if (newPassword.value == confirmNewPassword.value) {
        log('Coinciden las contraseñas');
        isRighBothPassword.value = true;
      } else {
        log('No coinciden las contraseñas');
        isRighBothPassword.value = false;
      }
    }
  }

  changePassword() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    if (isUserCheck.value == true) {
      if (isRighBothPassword.value == true) {
        Users newUser = await Users(
            id: userCheck.value.id,
            data: Data(
                name: userCheck.value.data?.name,
                lastName: userCheck.value.data?.lastName,
                phone: userCheck.value.data?.phone,
                picture: userCheck.value.data?.picture,
                routes: userCheck.value.data?.routes,
                password: newPassword.value));
        await updatePasswordUser(user: newUser);
        log('Clave actualizada con exito');
        sessionController.loadUsersData();
        Get.offAllNamed(AppRoutes.LOGIN);
        Get.defaultDialog(
            title: "Clave cambiada con exito",
            middleText: "Se cambio satisfactoriamente la clave");
      } else {
        log('Las claves no coinciden');
      }
    } else {
      if (isUserCheck.value == false && phone.isNotEmpty) {
        log('El usuario no existe');

        Get.defaultDialog(
            title: "Error al cambiar la clave",
            middleText:
                "El numero de celular: ${phone.value}, no esta registrado");
      }
    }
    isLoading.value = false;
    if (phone.value.isEmpty) {
      Get.defaultDialog(
          title: "Error al cambiar la clave",
          middleText:
              "Es necesario introducir un número de celular para poder continuar");
    }
    resetData();
  }

  isPhone() {
    if (phone.isNotEmpty && isUserCheck.value == true) {
      isTherePhone.value = true;
    } else {
      isTherePhone.value = false;
    }
  }

  isNewPassword() {
    if (newPassword.isNotEmpty) {
      isThereNewPassword.value = true;
    } else {
      isThereNewPassword.value = false;
    }
  }

  isConfirPassword() {
    if (confirmNewPassword.isNotEmpty && isRighBothPassword.value == true) {
      isThereConfirmPassword.value = true;
    } else {
      isThereConfirmPassword.value = false;
    }
  }

  resetData() {
    newPassword = "".obs;
    confirmNewPassword = "".obs;
    phone = "".obs;
    userCheck = Users().obs;
    indexUserCheck = 0.obs;
    isUserCheck = false.obs;
    isRighBothPassword = false.obs;
    isLoading = false.obs;
    isTherePhone = false.obs;
    isThereNewPassword = false.obs;
    isThereConfirmPassword = false.obs;
  }
}
