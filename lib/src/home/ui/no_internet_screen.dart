import 'package:assignment/src/custom_widget/textview.dart';
import 'package:assignment/src/util/utils.dart';
import 'package:assignment/src/values/custom_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoInternetScreen extends StatelessWidget {
  final double spacing;
  final BuildContext ctx;

  NoInternetScreen(this.ctx, this.spacing);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(
            left: spacing_xxl_10,
            right: spacing_xxl_10,
            top: spacing_xxl_6,
            bottom: spacing_xxl_6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/no_internet_placeholder.svg',
              height: spacing_xxl_18 * 2,
              width: spacing_xxl_18 * 2,
              fit: BoxFit.contain,
            ),
            TextView(
              title:
                  '${getStringFromLocale(ctx, 'connectionError').toUpperCase()}!',
              textStyle: commonTextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(spacing_xxl_2),
            ),
            TextView(
              title:
                  '${getStringFromLocale(ctx, 'checkAndTryInternetConnectivity').toUpperCase()}!',
              textStyle: commonTextStyle(color: Colors.black, fontSize: 12),
              padding: const EdgeInsets.all(spacing_xxl_2),
              alignment: Alignment.center,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
