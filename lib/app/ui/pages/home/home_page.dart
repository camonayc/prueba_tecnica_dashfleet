import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_tecnica_dashfleet/app/controllers/session_controller.dart';
import 'package:prueba_tecnica_dashfleet/app/ui/pages/home/widgets/widgets.dart';
import 'package:prueba_tecnica_dashfleet/app/ui/widgets/widgets.dart';

class HomeScreen extends GetView {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final SessionController _sessionController =
      SessionController.initializeController();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      bottomNavigationBar: AppNavBar(size: size),
      endDrawer: AppDrawer(
        size: size,
      ),
      body: GeneralScreen(
          user: _sessionController.currentUser.value,
          size: size,
          scaffoldKey: scaffoldKey,
          containScreen: ContainHomeScreen(size: size)),
    );
  }
}
