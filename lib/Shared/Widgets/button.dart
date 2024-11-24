import 'package:flutter/material.dart';

import '../Constants/colors.dart';
import 'text.dart';

class BuildButton extends StatelessWidget {
  var height;
  var width;
  var text;
  var function;
  Color? color = AppColors.color4;

  BuildButton(
      {required this.height,
      required this.width,
      required this.text,
      required this.function,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        child: MaterialButton(
          onPressed: function,
          child: BuildText(text: text, color: Colors.white),
          color: color,
        ));
  }
}
