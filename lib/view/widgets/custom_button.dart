
import 'package:asmaaadmin/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.text, required this.icon, this.onPress}) : super(key: key);
 final CustomText text;
 final Icon icon;
 final Function()? onPress;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPress,
        icon: icon,
        label: text);
  }
}
