import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonButton extends StatefulWidget {
  const CommonButton({
    Key? key,
    required this.callback,
    required this.fillColor,
    required this.borderColor,
    required this.title,
    this.textStyle,
    this.height = 60,
    this.isLoading = false,
    this.width,
  }) : super(key: key);
  final VoidCallback callback;
  final Color fillColor;
  final Color borderColor;
  final String title;
  final TextStyle? textStyle;
  final double height;
  final bool isLoading;
  final double? width;

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => widget.callback.call(),
      height: widget.height.h,
      minWidth: widget.width,
      color: widget.fillColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
        side: BorderSide(color: widget.borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.normal,
            color: Colors.white,
            fontSize: 20.sp),
          ),
          if (widget.isLoading)
            SizedBox(
              width: 15.w,
            ),
          if (widget.isLoading)
            SizedBox(
              height: 20.r,
              width: 20.r,
              child: CircularProgressIndicator(color: Colors.white),
            )
        ],
      ),
    );
  }
}
