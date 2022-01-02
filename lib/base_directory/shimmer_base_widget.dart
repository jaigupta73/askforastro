
import 'package:flutter/material.dart';

abstract class ShimmerBaseWidget extends StatelessWidget {
  final Color baseColor = const Color(0xFFE8E8E8);
  final Color highLightColor = Colors.grey.shade300;
  final Duration time = const Duration(milliseconds: 1000);

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

