import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:get/get.dart';
import 'package:prueba_tecnica_dashfleet/app/controllers/controllers.dart';
import 'package:prueba_tecnica_dashfleet/app/data/services/firebase_service.dart';
import 'package:prueba_tecnica_dashfleet/app/routes/routes.dart';
import 'package:prueba_tecnica_dashfleet/app/ui/pages/login/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  final LoginController _loginController =
      LoginController.initializeController();

  final SessionController _splashController =
      SessionController.initializeController();

  LoginScreen({Key? key}) : super(key: key);

  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () {
        if (_loginController.isLoading.value) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Colors.black),
            ),
          );
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.22,
                    width: size.width,
                    color: const Color.fromARGB(230, 0, 200, 73),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: size.height * 0.04)),
                        LoginText(size: size, title: "AMP APP"),
                        Padding(
                            padding: EdgeInsets.only(top: size.height * 0.01)),
                        LoginText(size: size, title: "Login"),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: size.height * 0.055,
                        left: size.height * 0.035,
                        right: size.height * 0.035),
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Celular",
                          style:
                              TextStyle(fontSize: size.height * 0.26 * 1 / 11),
                        ),
                        CustomTextFormField(
                          placeHolder: "Introduzca número de celular",
                          errorText:
                              _loginController.findErrorMessage("Celular"),
                          focusNode: _phoneFocusNode,
                          margin: const EdgeInsets.only(top: 10),
                          constraints: BoxConstraints(maxWidth: size.width),
                          onChangedFunction: (v) {
                            _loginController.phone.value = v;
                          },
                          onSubmittedFunction: (v) {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
                          },
                          inputType: TextInputType.number,
                          fillColor: Colors.white,
                          inputBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "Nota: Escribir primero el indicativo seguido del numero celular.  (Ejemplo: +1 1234567890)",
                          style: TextStyle(
                              fontSize: size.height * 0.26 * 1 / 14,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: size.height * 0.02)),
                        Text(
                          "Clave",
                          style:
                              TextStyle(fontSize: size.height * 0.26 * 1 / 11),
                        ),
                        CustomTextFormField(
                          placeHolder: "Introduzca clave de acceso",
                          errorText: null,
                          obscurer: true,
                          focusNode: _passwordFocusNode,
                          margin: const EdgeInsets.only(top: 10),
                          constraints: BoxConstraints(maxWidth: size.width),
                          onChangedFunction: (v) {
                            _loginController.password.value = v;
                          },
                          onSubmittedFunction: (v) async {
                            await _loginController.checkUserCredentials();
                            await _loginController.logIn();
                          },
                          inputType: TextInputType.text,
                          fillColor: Colors.white,
                          inputBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: size.height * 0.065)),
                        Row(
                          children: [
                            AdvancedSwitch(
                              controller: _loginController.remember.value,
                              activeColor:
                                  const Color.fromARGB(230, 0, 200, 73),
                              inactiveColor: Colors.grey,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              width: 60.0,
                              height: 22.0,
                              enabled: true,
                              disabledOpacity: 0.5,
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.only(left: size.height * 0.03)),
                            Text(
                              "Recordar",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.height * 0.26 * 1 / 12),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: size.height * 0.15,
                              left: size.height * 0.09,
                              right: size.height * 0.09),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Custom_Button(
                                  title: "Entrar",
                                  size: size,
                                  loginController: _loginController),
                              TextButton(
                                style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent)),
                                child: Text(
                                  "Olvido su clave?",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.height * 0.26 * 1 / 11),
                                ),
                                onPressed: () {
                                  Get.toNamed(AppRoutes.RECOVER);
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
