import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class OptionCardWidget extends StatefulWidget {
  const OptionCardWidget({Key? key,
    required this.title,
    required this.icon,
    required this.index,
    this.user_data,
    this.logout,
    this.email,
    required this.callback,

  }) : super(key: key);
  final String title;
  final IconData icon;
  final int index;
  final bool? logout;
  final Map<String, dynamic>? user_data;
  final String? email;
  final VoidCallback callback;


  @override
  State<OptionCardWidget> createState() => _OptionCardWidgetState();
}

class _OptionCardWidgetState extends State<OptionCardWidget> {

  @override
  void initState() {
    super.initState();
    print(widget.user_data);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.callback.call(),
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1.2,
              blurRadius: 5,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    widget.icon,
                    color: widget.logout == true ? Colors.red
                        :Colors.purple,
                    size: 16.sp,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    widget.title,
                    style:
                    TextStyle(fontWeight: FontWeight.normal, fontSize: 14.sp),
                  ),
                ],
              ),
              IconButton(
                onPressed: widget.callback,
                icon: Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.purple,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

