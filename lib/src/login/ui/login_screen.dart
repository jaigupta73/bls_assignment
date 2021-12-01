import 'package:assignment/src/base_directory/base_get_state.dart';
import 'package:assignment/src/custom_widget/textview.dart';
import 'package:assignment/src/login/controller/login_controller.dart';
import 'package:assignment/src/util/utils.dart';
import 'package:assignment/src/values/custom_colors.dart';
import 'package:assignment/src/values/custom_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseGetState<LoginScreen> {
  LoginController loginController = LoginController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginController.loadUserData();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // executes after build
    });
  }

  @override
  Widget getBuildWidget(BuildContext context) {
    // TODO: implement getBuildWidget
    return GetBuilder(
      global: false,
      init: loginController,
      builder: (LoginController controller) {
        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(spacing_xxl_2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/logo.svg',
                      width: 200,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: spacing_xxl_12),
                      child: TextFormField(
                        controller: loginController.userNameEditingController,
                        textInputAction: TextInputAction.next,
                        focusNode: loginController.userNameFocusNode,
                        style: commonTextStyle(fontSize: 15),
                        validator: (val) => controller.validateTextField(val!,
                            errorMsg:
                                '${getString('userName')} ${getString('errorMsg')}'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onSaved: (value) {},
                        onFieldSubmitted: (v) {
                          // _fieldFocusChange(
                          //     context, controller.monoFocus, controller.almonoFocus);
                        },
                        onChanged: (value) {
                          loginController.checkButtonValidation();
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          counterText: "",
                          errorStyle: commonTextStyle(
                              fontWeight: FontWeight.normal, color: Colors.red),
                          labelText: getString('userName'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: spacing_xxl_4),
                      child: TextFormField(
                        controller: loginController.passEditingController,
                        textInputAction: TextInputAction.done,
                        focusNode: loginController.passwordFocusNode,
                        obscureText: true,
                        obscuringCharacter: '*',
                        style: commonTextStyle(fontSize: 15),
                        validator: (val) => controller.validateTextField(val!,
                            errorMsg:
                                '${getString('password')} ${getString('errorMsg')}'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onSaved: (value) {},
                        onChanged: (value) {
                          loginController.checkButtonValidation();
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          counterText: "",
                          errorStyle: commonTextStyle(
                              fontWeight: FontWeight.normal, color: Colors.red),
                          labelText: getString('password'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: overlay_24,
                    blurRadius: 8,
                    spreadRadius: 0,
                    offset: Offset(0.0, 1.5),
                  ),
                ],
                color: Colors.white,
              ),
              padding: EdgeInsets.all(spacing_xxl_2),
              child: Obx(() {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: colorPrimary,
                    textStyle: commonTextStyle(color: Colors.white),
                  ),
                  onPressed: controller.isEnableSubmitButton.value
                      ? () async {
                          var user =
                              await loginController.signInWithEmailAndPassword(
                                  loginController
                                      .userNameEditingController.text,
                                  loginController.passEditingController.text);
                          // appLog('user $user');
                          if (user != null) {
                            loginController.saveLoginData(user);

                          } else {
                            showSnackbar(getString('loginError'));
                          }
                        }
                      : null,
                  child: TextView(
                    alignment: Alignment.center,
                    title: getString('continue'),
                    textStyle:
                        commonTextStyle(color: Colors.white, fontSize: 15),
                  ),
                );
              }),
            )
          ],
        );
      },
    );
  }

  @override
  Color? getScreenColor() {
    // TODO: implement getScreenColor
    return Colors.white;
  }

  @override
  void onScreenReady(BuildContext context) {
    // TODO: implement onScreenReady
  }
}
