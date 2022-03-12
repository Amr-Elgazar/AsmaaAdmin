import 'package:flutter/material.dart';

class CustomPadding extends StatelessWidget {
  const CustomPadding({Key? key, required this.vertical, required this.horizontal, required this.child}) : super(key: key);
  final double vertical;
  final double horizontal;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      child: child,
        padding: EdgeInsets.symmetric(vertical: vertical,horizontal: horizontal,));
  }
}
