import 'package:flutter/material.dart';
class SheetItem extends StatelessWidget {
  final Function onPressed;
  final Widget icon;
  final  Widget label;

  SheetItem({this.onPressed, this.icon, this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        leading: icon,
        title: label,
      ),
    );
  }
}