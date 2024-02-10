import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReusabeTextField extends StatefulWidget {
  const ReusabeTextField({
    Key? key,
    required this.hint_text,
    required this.controller,
     this.icon,
    this.label_text,
    this.text,
    this.password,
    this.email,
    this.language,
    this.place,
    this.state,
    this.caste,
    this.country,
    this.education,
    this.hgt,
    this.wgt,
    this.pincode,
    this.phn,
    this.religion,
    this.edit_profile,
    this.user_data,
    this.mother_tongue,
    this.validator,
    this.initialValue,
    this.keyboardType,
    required this.onChange,


  }) : super(key: key);

  final String hint_text;
  final TextEditingController controller;
  final Icon? icon;
  final String? label_text;
  final String? text;
  final bool? password;
  final bool? email;
  final bool? language;
  final bool? religion;
  final bool? pincode;
  final bool? caste;
  final bool? place;
  final bool? state;
  final bool? country;
  final bool? hgt;
  final bool? wgt;
  final bool? education;
  final bool? mother_tongue;
  final TextInputType? keyboardType;
  final String? initialValue; // Initial value parameter


  final bool? phn;
  final bool? edit_profile;
  final Map<String, dynamic>? user_data;
  final String? Function(String?)? validator;
  final void Function(String) onChange;
  @override
  State<ReusabeTextField> createState() => _ReusabeTextFieldState();
}

class _ReusabeTextFieldState extends State<ReusabeTextField> {

  String? check_valid_email;

  @override
  void initState() {
    super.initState();
    // if (widget.initialValue != null) {
    //   widget.controller.text = widget.initialValue!;
    //   print('aaa${widget.controller.text}');
    //
    // }
    _initialValue ();

  }

  void _initialValue (){
    print('mmmm');
    if(widget.edit_profile == true){
      if(widget.phn == true){
        print('a');

        widget.controller.text = widget.user_data!['phone'] ?? '';
      }else if(widget.email == true){
        print('b');

        widget.controller.text = widget.user_data!['email'] ?? '';
      }
      else if(widget.religion == true){
        print('c');

        widget.controller.text = widget.user_data!['religion'] ?? '';
      }else if(widget.country == true){
        print('d');

        widget.controller.text = widget.user_data!['country'] ?? '';
      }else if(widget.caste == true){
        print('e');

        widget.controller.text = widget.user_data!['caste'] ?? '';
      }else if(widget.state == true){
        print('f');

        widget.controller.text = widget.user_data!['state'] ?? '';
      }else if(widget.place == true){
        print('g');

        widget.controller.text = widget.user_data!['location'] ?? '';
      }else if(widget.education == true){
        print('h');

        widget.controller.text = widget.user_data!['education'] ?? '';
      }else if(widget.hgt == true){
        print('i');

        widget.controller.text = widget.user_data!['height'] ?? '';
      }else if(widget.wgt == true){
        print('j');

        widget.controller.text = widget.user_data!['weight'] ?? '';
      }else if(widget.language == true){
        print('k');

        widget.controller.text = widget.user_data!['mother_tongue'] ?? '';
      }else if(widget.pincode == true){
        print('l');

        widget.controller.text = widget.user_data!['pincode'] ?? '';
      }else{
        widget.controller.text = widget.user_data!['name'] ?? '';
      }

    }
  }


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
        ? Container(
          width: double.infinity,
          child: TextFormField(
            validator: widget.validator,
            onChanged: widget.onChange,

            // {
            //   if (value == null || value.isEmpty) {
            //     return 'Please enter this field';
            //   }else if(widget.password == true){
            //     if (value.length < 6) {
            //       return 'Password must be at least 6 characters';
            //     }
            //   }else if(widget.email == true){
            //     final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
            //     if (!emailRegex.hasMatch(value)) {
            //       return 'Please enter a valid email address';
            //     }
            //
            //   }else if(widget.phn == true){
            //     if (value.length < 10) {
            //       return 'Phome number must be 10 characters';
            //     }
            //   }
            //   return null;
            // },
            maxLines: null,
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            decoration: InputDecoration(
              labelText: widget.label_text,
              hintText: widget.hint_text,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: widget.icon,




            ),
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
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10), // Set the max number of characters to 10

                    ],
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
