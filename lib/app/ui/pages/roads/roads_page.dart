import 'package:flutter/material.dart';
import 'package:prueba_tecnica_dashfleet/app/controllers/session_controller.dart';
import 'package:prueba_tecnica_dashfleet/app/ui/pages/roads/widgets/widgets.dart';
import 'package:prueba_tecnica_dashfleet/app/ui/widgets/widgets.dart';

class RoadsScreen extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final SessionController _sessionController =
      SessionController.initializeController();
  RoadsScreen({Key? key}) : super(key: key);

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
          containScreen: ContainRoadsScreen(
              user: _sessionController.currentUser.value, size: size)),
    );
  }
}



