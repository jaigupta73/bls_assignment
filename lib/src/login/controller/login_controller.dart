import 'dart:convert';

import 'package:assignment/src/base_directory/base_get_controller.dart';
import 'package:assignment/src/home/models/tournament_response_model.dart';
import 'package:assignment/src/home/ui/home_screen.dart';
import 'package:assignment/src/login/models/user.dart' as user_data;
import 'package:assignment/src/preferences/app_preference.dart';
import 'package:assignment/src/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginController extends BaseGetController {
  Rx<bool> isEnableSubmitButton = false.obs, isUserLogin = false.obs;
  int minNameLimit = 3, maxLimit = 11;
  FocusNode userNameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController userNameEditingController = TextEditingController();
  TextEditingController passEditingController = TextEditingController();
  List<user_data.Data> userInfo = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validateTextField(String text, {String? errorMsg}) {
    return text.trim().length >= minNameLimit && text.trim().length <= maxLimit
        ? null
        : errorMsg;
  }

  void checkButtonValidation() {
    if (userNameEditingController.text.length >= minNameLimit &&
        userNameEditingController.text.length <= maxLimit &&
        passEditingController.text.length >= minNameLimit &&
        passEditingController.text.length <= maxLimit) {
      isEnableSubmitButton.value = true;
    } else {
      isEnableSubmitButton.value = false;
    }
  }

  Future<void> loadUserData() async {
    userInfo = await loadJsonData();
  }

  Future<user_data.Data?> signInWithEmailAndPassword(
      String userName, String password) async {
    await Future.delayed(Duration(seconds: 2));

    try {
      return userInfo
          .where((element) =>
              element.username == userName && element.password == password)
          .first;
    } catch (e) {
      print(e);
    }
    return null;
  }

  void saveLoginData(user_data.Data data) {
    AppPreferences.setUserID(data.id);
    goToNextScreen(HomeScreen(), 'homeScreen');
  }
}
