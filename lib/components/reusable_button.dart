import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableButton extends StatefulWidget {
  const ReusableButton(
      {Key? key,
      required this.text,
      required this.fullname,
      required this.email,
      required this.password,
      required this.gender,
      required this.sign_up,
        required this.onPressed,
        required this.isLoading,
      })
      : super(key: key);

  final String text;
  final String fullname;
  final String password;
  final String email;
  final String gender;
  final bool sign_up;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  State<ReusableButton> createState() => _ReusableButtonState();
}

class _ReusableButtonState extends State<ReusableButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width.w,
      child: ElevatedButton(
        onPressed: () {
          if (widget.sign_up == true) {
            print(widget.sign_up);
            if ((widget.fullname.isEmpty) ||
                (widget.email.isEmpty) ||
                (widget.password.isEmpty) ||
                (widget.gender.isEmpty)) {
              print('Fields are empty ${widget.isLoading}, ${widget.onPressed}');
              widget.isLoading ? null : {widget.onPressed};
            } else {
            }
          }
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.purple,
        ),
        child: Text(
          widget.text,
          style: TextStyle(fontSize: 20.sp, color: Colors.white),
        ),
      ),
    );
  }
}
