
import 'package:flutter/material.dart';

abstract class ShimmerBaseWidget extends StatelessWidget {
  final Color baseColor = const Color(0xFFE8E8E8);
  final Color highLightColor = Colors.white70;
  final Duration time = const Duration(milliseconds: 750);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: getBuildWidget(context),
    );
  }
  Widget getBuildWidget(BuildContext context);
}

