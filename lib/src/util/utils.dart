import 'dart:convert';
import 'dart:io';
import 'package:assignment/src/custom_widget/textview.dart';
import 'package:assignment/src/home/ui/home_screen.dart';
import 'package:assignment/src/login/models/user.dart' as user_data;
import 'package:assignment/src/preferences/app_preference.dart';
import 'package:assignment/src/values/custom_dimensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Future<bool> isConnected() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}



String getStringFromLocale(BuildContext ctx, String tag) {
  return tag.tr;
}

void appLog(dynamic message) {
  if (kDebugMode) print(message);
}

String getLanguageNameFromCode(String code) {
  String value = '';
  switch (code) {
    case 'en':
      value = 'English';
      break;
  }
  return value;
}

bool nonNullNotEmpty(dynamic value) {
  if (value != null) {
    if (value is List || value is Map) return value.length > 0;
    if (value is String) return value.isNotEmpty;
    if (value is int || value is double) return value != 0;
  }
  return false;
}

bool nonNull(dynamic value) {
  return value != null;
}

TextStyle commonTextStyle(
    {Color color = Colors.black,
    double fontSize = text_12,
    TextDecoration decoration = TextDecoration.none,
    fontWeight = FontWeight.w500}) {
  return GoogleFonts.poppins(
      textStyle: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
          letterSpacing: 0.4,
          decoration: decoration));
}

void showSnackbar(String msg) {
  GetBar(
    duration: Duration(seconds: 5),
    dismissDirection: SnackDismissDirection.HORIZONTAL,
    animationDuration: const Duration(milliseconds: 300),
    snackbarStatus: (status) {
      if (status == SnackbarStatus.OPENING ||
          status == SnackbarStatus.CLOSED) {}
      appLog("status ------> $status");
    },
    messageText:
        TextView(title: msg, textStyle: commonTextStyle(color: Colors.white)),
  ).show();
}

Future<user_data.Data> getUserData() async {
  List<user_data.Data> userList = await loadJsonData();

  return userList
      .where((element) => element.id == AppPreferences.getUserID())
      .first;
}

Future<List<user_data.Data>> loadJsonData() async {
  var userData = await rootBundle.loadString('assets/config/user.json');
  appLog('loadJsonData ${jsonDecode(userData)}');
  return user_data.User.fromJson(jsonDecode(userData)).data;
}

goToNextScreen(dynamic screenWidget, String routeName) {
  Navigator.of(Get.context!).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return screenWidget;
        },
        settings: RouteSettings(name: routeName),
      ),
      (route) => false);
}
