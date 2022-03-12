import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({Key? key, required this.text, this.icon, this.iconButton}) : super(key: key);
  final String text;
  final Icon? icon;
  final IconButton? iconButton;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: text,
        prefixIcon: icon,
        suffixIcon: iconButton,
        border: OutlineInputBorder()
      ),
    );
  }
}
