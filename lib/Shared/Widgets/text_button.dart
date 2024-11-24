import 'package:flutter/material.dart';

import 'text.dart';

class BuildTextButton extends StatelessWidget {
  var text;
  var function;
  BuildTextButton({required this.text, required this.function});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: function, child: BuildText(text: text));
  }
}
