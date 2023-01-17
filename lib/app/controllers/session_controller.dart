import 'dart:developer';

import 'package:get/get.dart';
import 'package:prueba_tecnica_dashfleet/app/data/models/models.dart';
import 'package:prueba_tecnica_dashfleet/app/data/services/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionController extends GetxController {
  static SessionController initializeController() {
    try {
      SessionController controller = Get.find<SessionController>();
      return controller;
    } catch (e) {
      SessionController controller = Get.put(SessionController());
      return controller;
    }
  }

  RxBool dateLoading = false.obs;
  RxList<Users> users = <Users>[].obs;

  RxBool isRememberUser = false.obs;

  Rx<Users> currentUser = Users().obs;

  void loadUsersData() async {
    final response = await getUsers();
    for (var i = 0; i < response.length; i++) {
      Users newUser = Users.fromMap(response[i]);
      users.add(newUser);
    }
    dateLoading.value = true;
    log("GetData");
  }

  checkUserCredentialsRemember(
      {required String phone, required String password}) {
    for (var user in users) {
      if (user.data?.password == password && user.data?.phone == phone) {
        currentUser.value = user;
      }
    }
  }

  Future<bool> rememberUser() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('userPhone') != "" &&
        prefs.getString('userPassword') != "") {
      await checkUserCredentialsRemember(
          phone: prefs.getString('userPhone')!,
          password: prefs.getString('userPassword')!);
      isRememberUser.value = true;
      return isRememberUser.value;
    }
    isRememberUser.value = false;
    return isRememberUser.value;
  }
}
