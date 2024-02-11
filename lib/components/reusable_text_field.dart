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
    this.father,
    this.mother,
    this.age,
    this.description,
    this.siblings,
    this.job,
    this.gender,
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
  final bool? father;
  final bool? mother;
  final bool? age;
  final bool? description;
  final bool? siblings;
  final bool? job;
  final TextInputType? keyboardType;
  final String? initialValue;
  final bool? phn;
  final bool? gender;
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
    _initialValue ();

  }

  void _initialValue (){
    print('mmmm');
    if(widget.edit_profile == true){
      if(widget.phn == true){
        widget.controller.text = widget.user_data!['phone'] ?? '';
      }else if(widget.email == true){
        widget.controller.text = widget.user_data!['email'] ?? '';
      }
      else if(widget.religion == true){
        widget.controller.text = widget.user_data!['religion'] ?? '';
      }else if(widget.country == true){
        widget.controller.text = widget.user_data!['country'] ?? '';
      }else if(widget.caste == true){
        widget.controller.text = widget.user_data!['caste'] ?? '';
      }else if(widget.state == true){
        widget.controller.text = widget.user_data!['state'] ?? '';
      }else if(widget.place == true){
        widget.controller.text = widget.user_data!['location'] ?? '';
      }else if(widget.education == true){
        widget.controller.text = widget.user_data!['education'] ?? '';
      }else if(widget.hgt == true){
        widget.controller.text = widget.user_data!['height'] ?? '';
      }else if(widget.wgt == true){
        widget.controller.text = widget.user_data!['weight'] ?? '';
      }else if(widget.language == true){
        widget.controller.text = widget.user_data!['mother_tongue'] ?? '';
      }else if(widget.pincode == true){
        widget.controller.text = widget.user_data!['pincode'] ?? '';
      }else if(widget.father == true){
        widget.controller.text = widget.user_data!['father_name'] ?? '';
      }else if(widget.mother == true){
        widget.controller.text = widget.user_data!['mother_name'] ?? '';
      }else if(widget.age == true){
        widget.controller.text = widget.user_data!['age'] ?? '';
      }else if(widget.description == true){
        widget.controller.text = widget.user_data!['about_family'] ?? '';
      }else if(widget.job == true) {
        widget.controller.text = widget.user_data!['job'] ?? '';
      }
      else if(widget.siblings == true){
        widget.controller.text = widget.user_data!['siblings'] ?? '';
      }else if(widget.gender == true){
        widget.controller.text = widget.user_data!['gender'] ?? '';
      }
      else{
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
            readOnly:  widget.email == true && widget.edit_profile == true ? true : false,
            validator: widget.validator,
            onChanged: widget.onChange,
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
