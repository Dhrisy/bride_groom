import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusabeTextField extends StatefulWidget {
  const ReusabeTextField({
    Key? key,
    required this.hint_text,
    required this.controller,
    required this.icon,
    this.text,
  }) : super(key: key);

  final String hint_text;
  final TextEditingController controller;
  final Icon icon;
  final String? text;

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
