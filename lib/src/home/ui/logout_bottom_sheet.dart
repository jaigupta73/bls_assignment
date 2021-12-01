import 'package:assignment/src/app_secret_config/app_secret_config.dart';
import 'package:assignment/src/custom_widget/textview.dart';
import 'package:assignment/src/login/ui/login_screen.dart';
import 'package:assignment/src/util/utils.dart';
import 'package:assignment/src/values/custom_colors.dart';
import 'package:assignment/src/values/custom_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget getLogoutBottomSheet() {
  return Container(
    height: Get.height,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(Get.context!).pop();
              },
              child: Container(
                height: spacing_xxl_18,
                width: spacing_xxl_18,
                margin: EdgeInsets.all(spacing_xxl_2),
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.4),
                        blurRadius: 10.0, // soften the shadow
                        spreadRadius: 0.0, //extend the shadow
                        offset: Offset(
                          1.0, // Move to right 10  horizontally
                          1.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ]),
                child: Center(
                  child: Icon(Icons.clear_rounded),
                ),
              ),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(Get.context!).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(spacing_xl),
              topRight: Radius.circular(spacing_xl),
            ),
            color: app_backgroud,
          ),
          padding: EdgeInsets.all(spacing_xxl_2),
          child: TextView(
            title: getStringFromLocale(Get.context!, "logoutTitle"),
            textStyle: commonTextStyle(color: Colors.black26, fontSize: 20),
          ),
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(spacing_xxl_2),
          child: Column(
            children: [
              TextView(
                title: getStringFromLocale(Get.context!, "logoutConfirm"),
                textStyle: commonTextStyle(color: Colors.black87, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spacing_xxl_10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: colorPrimary,
                  textStyle: commonTextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(Get.context!).pop();
                  AppSecretConfig.instance.preferences.clear();
                  goToNextScreen(LoginScreen(), 'loginScreen');
                },
                child: TextView(
                  alignment: Alignment.center,
                  title: getStringFromLocale(Get.context!, 'yes'),
                  textStyle: commonTextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              SizedBox(height: spacing_m),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  textStyle: commonTextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(Get.context!).pop();
                },
                child: TextView(
                  alignment: Alignment.center,
                  title: getStringFromLocale(Get.context!, 'notNow'),
                  textStyle: commonTextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
  ;
}
