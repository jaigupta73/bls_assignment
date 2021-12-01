import 'package:assignment/src/base_directory/base_get_state.dart';
import 'package:assignment/src/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseGetState<SplashScreen> {
  SplashController splashController = SplashController();

  @override
  Widget getBuildWidget(BuildContext context) {
    // TODO: implement getBuildWidget
    return GetBuilder(
      init: splashController,
      global: false,
      builder: (controller) {
        return Stack(
          children: [
            Container(
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: 200,
                ),
              ),
            ),
            Positioned(
                right: 0,
                child: SvgPicture.asset(
                  'assets/images/game.svg',
                  width: 200,
                  color: Colors.black26,
                )),
            Positioned(
                bottom: 0,
                child: SvgPicture.asset(
                  'assets/images/game.svg',
                  width: 200,
                  color: Colors.black26,
                ))
          ],
        );
      },
    );
  }

  @override
  void onScreenReady(BuildContext context) {
    // TODO: implement onScreenReady
    splashController.goToScreen();
  }
}
