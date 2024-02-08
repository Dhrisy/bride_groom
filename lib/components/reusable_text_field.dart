import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReusabeTextField extends StatefulWidget {
  const ReusabeTextField({
    Key? key,
    required this.hint_text,
    required this.controller,
    required this.icon,
    this.text,
    this.password,
    this.email,
    this.phn,
  }) : super(key: key);

  final String hint_text;
  final TextEditingController controller;
  final Icon icon;
  final String? text;
  final bool? password;
  final bool? email;
  final bool? phn;

  @override
  State<ReusabeTextField> createState() => _ReusabeTextFieldState();
}

class _ReusabeTextFieldState extends State<ReusabeTextField> {

  String? check_valid_email;


  // Future<void> saveUserDataToSharedPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   check_valid_email;
  //   print('Email: ${prefs.getString('email')}');
  //   print('Password: ${prefs.getString('pass_word')}');
  //
  // }

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
        widget.phn == false
        ? TextFormField(
          validator: (value) {
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

            }else if(widget.phn == true){
              if (value.length < 10) {
                return 'Phome number must be 10 characters';
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
        )

            :   Container(
          height: 55.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              borderRadius: BorderRadius.all(Radius.circular(18.r))
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Row(mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(Icons.phone),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text('+91',
                    style: TextStyle(
                        fontSize: 14.sp
                    )
                ),
                Expanded(
                  child: TextFormField(
                    controller: widget.controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter phone number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),

                      fillColor: Colors.transparent,
                      filled: true,
                      // prefixIcon: Icon(Icons.phone),

                    ),

                  ),
                ),

              ],
            ),
          ),
        ),

      ],
    );
  }
}
