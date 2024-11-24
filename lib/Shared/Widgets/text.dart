import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildText extends StatelessWidget {
  late String text;
  double size;
  Color? color;
  bool? bold;
  int? maxLines;
  bool? overFlow;
  bool? lineThrow;
  bool? center;

  BuildText(
      {required this.text,
        this.size = 18,
        this.color,
        this.bold,
        this.maxLines,
        this.overFlow,
        this.lineThrow,
        this.center});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow == null ? null : TextOverflow.ellipsis,
      maxLines: maxLines == null ? null : maxLines,
      style: GoogleFonts.lato(
        color: color,
        fontSize: size,
        fontWeight: bold != null ? FontWeight.bold : null,
        decoration: lineThrow != null ? TextDecoration.lineThrough : null,
      ),
      textAlign: center == null ? null : TextAlign.center,
    );
  }
}
