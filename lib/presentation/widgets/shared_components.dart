import 'package:flutter/material.dart';

ScaffoldFeatureController buildSnackBar({String text,BuildContext context}){
  return  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      padding: EdgeInsets.all(8),
      content: Text(text,textAlign: TextAlign.center,),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)))
  ));
}