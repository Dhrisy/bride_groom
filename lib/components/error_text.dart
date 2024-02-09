import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 10.w,
        ),
        Text(
          'Please enter this field',
          style: TextStyle(
              color: Colors.red[900],
              fontSize: 12.sp,
              fontWeight: FontWeight.normal),
        )
      ],
    );
  }
}
