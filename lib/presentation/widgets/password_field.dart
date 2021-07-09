import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  PasswordField({this.controller,this.hint});
  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isSecure=true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(obscureText:isSecure ,validator:(val){
          if(val.isEmpty){
            return "Required Field";
          }
          if(val.length<9){
            return "Try Something Longer Than 9 Digits ";
          }
          else{return null;}
        } ,
          controller: widget.controller,
          decoration: InputDecoration(
              icon: Icon(Icons.lock_outline), hintText:widget.hint),
        ),
        Positioned(
          child: IconButton(
            icon: Icon(isSecure?Icons.visibility_outlined:Icons.visibility_off_outlined),
            onPressed: () {
              setState(() {
                if(isSecure){
                  isSecure=false;
                }else{
                  isSecure=true;
                }
              });
            },
          ),
          right: 0.0,
        )
      ],
    );
  }
}
