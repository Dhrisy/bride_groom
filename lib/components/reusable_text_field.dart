import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusabeTextField extends StatefulWidget {
  const ReusabeTextField({
    Key? key,
    required this.hint_text,
    required this.controller,
    required this.icon,
    this.text,
    this.password,
    this.email,
  }) : super(key: key);

  final String hint_text;
  final TextEditingController controller;
  final Icon icon;
  final String? text;
  final bool? password;
  final bool? email;

  @override
  State<ReusabeTextField> createState() => _ReusabeTextFieldState();
}

class _ReusabeTextFieldState extends State<ReusabeTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 5.h,
            ),
            widget.text != null ? Text(
              widget.text.toString(),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
            )
                : SizedBox.shrink()

          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        TextFormField(
          validator: (value){
            if (value == null || value.isEmpty) {
              return 'Please enter this field';
            }else if(widget.password == true){
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
            }else if(widget.email == true){
              final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
              if (!emailRegex.hasMatch(value)) {
                return 'Please enter a valid email address';
              }
            }
            return null;
          },
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hint_text,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Colors.purple.withOpacity(0.1),
            filled: true,
            prefixIcon: widget.icon,

          ),
        ),
      ],
    );
  }
}
