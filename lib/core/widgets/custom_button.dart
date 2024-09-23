
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, this.onTap, required this.label, required this.color, required this.txtColor});
  final void Function()? onTap;
  final String label;
  final Color color,txtColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Center(child: Text(label,style: TextStyle(
          fontWeight: FontWeight.bold,
          color: txtColor,
        ),)),
      ),
    );
  }
}
