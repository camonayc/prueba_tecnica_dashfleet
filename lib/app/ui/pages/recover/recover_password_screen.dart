import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_tecnica_dashfleet/app/controllers/recover_controller.dart';
import 'package:prueba_tecnica_dashfleet/app/ui/pages/recover/widgets/widgets.dart';

class RecoverPasswordScreen extends StatelessWidget {


  final RecoverController _recoverController =
      RecoverController.initializeController();

  RecoverPasswordScreen({Key? key}) : super(key: key);

  final FocusNode _phoneNumber = FocusNode();
  final FocusNode _newPasswordFocusNode = FocusNode();
  final FocusNode _confirmNewPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () {
        if (_recoverController.isLoading.value == true) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Colors.black),
            ),
          );
        }
        return Scaffold(
            body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: size.height * 0.04),
                child: Row(
                  children: [
                    IconButton(
                        splashRadius: 1,
                        onPressed: () async {
                          await _recoverController.resetData();
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: size.height * 0.06),
                child: Text(
                  "Cambio de clave",
                  style: TextStyle(fontSize: size.height * 0.26 * 1 / 8),
                ),
              ),
              Text(
                "Numero celular",
                style: TextStyle(fontSize: size.height * 0.26 * 1 / 11),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.height * 0.08),
                child: CustomTextFormField(
                  placeHolder: "Introduzca su numero celular",
                  focusNode: _phoneNumber,
                  margin: const EdgeInsets.only(top: 10),
                  constraints: BoxConstraints(maxWidth: size.width),
                  onChangedFunction: (v) {
                    _recoverController.phone.value = v;
                  },
                  onSubmittedFunction: (v) {
                    _recoverController.phone.value = v;
                    _recoverController.checkUser();
                    _recoverController.isPhone();
                  },
                  inputType: TextInputType.number,
                  fillColor: Colors.white,
                  inputBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: size.height * 0.05, right: size.height * 0.05),
                child: Text(
                  textAlign: TextAlign.center,
                  "Nota: Escribir primero el indicativo seguido del numero celular.  (Ejemplo: +1 1234567890)",
                  style: TextStyle(
                      fontSize: size.height * 0.26 * 1 / 14,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: size.height * 0.02)),
              Text(
                "Nueva clave",
                style: TextStyle(fontSize: size.height * 0.26 * 1 / 11),
              ),
              Obx(
                () {
                  if (_recoverController.isTherePhone.value == true) {
                    return NewPassword(
                      enable: true,
                      size: size,
                      newPasswordFocusNode: _newPasswordFocusNode,
                      onChangedFunction: (v) {
                        _recoverController.newPassword.value = v;
                      },
                      onSubmittedFunction: (v) async {
                        _recoverController.newPassword.value = v;
                        await _recoverController.isNewPassword();
                      },
                    );
                  }
                  return NewPassword(
                    enable: false,
                    size: size,
                    newPasswordFocusNode: _newPasswordFocusNode,
                    onChangedFunction: (v) {},
                    onSubmittedFunction: (v) {},
                  );
                },
              ),
              Padding(padding: EdgeInsets.only(top: size.height * 0.05)),
              Text(
                "Confirmar clave",
                style: TextStyle(fontSize: size.height * 0.26 * 1 / 11),
              ),
              Obx(
                () {
                  if (_recoverController.isThereNewPassword.value == true) {
                    return ConfirmPassword(
                      enable: true,
                      size: size,
                      confirmNewPasswordFocusNode: _confirmNewPasswordFocusNode,
                      onChangedFunction: (v) {
                        _recoverController.confirmNewPassword.value = v;
                      },
                      onSubmittedFunction: (v) {
                        _recoverController.confirmNewPassword.value = v;
                        _recoverController.checkPassword();
                        _recoverController.isConfirPassword();
                      },
                    );
                  }
                  return ConfirmPassword(
                    enable: false,
                    size: size,
                    confirmNewPasswordFocusNode: _confirmNewPasswordFocusNode,
                    onChangedFunction: (v) {},
                    onSubmittedFunction: (v) {},
                  );
                },
              ),
              Obx(
                () {
                  if (_recoverController.isThereConfirmPassword.value == true) {
                    return CustomButton(
                        title: "Confirmar",
                        margin: EdgeInsets.symmetric(
                            horizontal: size.height * 0.12,
                            vertical: size.height * 0.1),
                        size: size,
                        onPressed: () {
                          _recoverController.changePassword();
                        });
                  }
                  return Container();
                },
              )
            ],
          ),
        ));
      },
    );
  }
}

class ConfirmPassword extends StatelessWidget {
  const ConfirmPassword({
    Key? key,
    required this.size,
    required FocusNode confirmNewPasswordFocusNode,
    required this.enable,
    required this.onChangedFunction,
    required this.onSubmittedFunction,
  })  : _confirmNewPasswordFocusNode = confirmNewPasswordFocusNode,
        super(key: key);

  final Size size;
  final FocusNode _confirmNewPasswordFocusNode;
  final bool enable;
  final Function(String) onChangedFunction;
  final Function(String) onSubmittedFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.height * 0.08),
      child: CustomTextFormField(
        enableInput: enable,
        obscurer: true,
        placeHolder: "confirmar la nueva clave",
        focusNode: _confirmNewPasswordFocusNode,
        margin: const EdgeInsets.only(top: 10),
        constraints: BoxConstraints(maxWidth: size.width),
        onChangedFunction: (v) {
          onChangedFunction(v);
        },
        onSubmittedFunction: (v) {
          onSubmittedFunction(v);
        },
        inputType: TextInputType.number,
        fillColor: Colors.white,
        inputBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }
}

class NewPassword extends StatelessWidget {
  const NewPassword({
    Key? key,
    required this.size,
    required FocusNode newPasswordFocusNode,
    required this.enable,
    required this.onChangedFunction,
    required this.onSubmittedFunction,
  })  : _newPasswordFocusNode = newPasswordFocusNode,
        super(key: key);

  final Size size;
  final FocusNode _newPasswordFocusNode;
  final bool enable;
  final Function(String) onChangedFunction;
  final Function(String) onSubmittedFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.height * 0.08),
      child: CustomTextFormField(
        enableInput: enable,
        obscurer: true,
        placeHolder: "Introduzca la nueva clave",
        focusNode: _newPasswordFocusNode,
        margin: const EdgeInsets.only(top: 10),
        constraints: BoxConstraints(maxWidth: size.width),
        onChangedFunction: onChangedFunction,
        onSubmittedFunction: onSubmittedFunction,
        inputType: TextInputType.number,
        fillColor: Colors.white,
        inputBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }
}
