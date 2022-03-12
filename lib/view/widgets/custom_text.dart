import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final double? fontSize;
  CustomText({ required this.text, this.fontWeight, this.textOverflow, this.maxLines, this.fontSize, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        overflow: textOverflow,
      ),
      maxLines: maxLines,
    );
  }
}
