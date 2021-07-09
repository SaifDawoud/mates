import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color borderColor;
  final Color fillinColor;
  final Function onPressed;
  final Widget child;
  RoundedButton(
      {this.borderColor, this.child, this.fillinColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        padding: EdgeInsets.all(15),
        child: child,
        decoration: BoxDecoration(
            color: fillinColor,
            borderRadius: BorderRadius.circular(10),
            border: Border(
                bottom: BorderSide(color: borderColor),
                left: BorderSide(color: borderColor),
                right: BorderSide(color: borderColor),
                top: BorderSide(color: borderColor))),
      ),
    );
  }
}
