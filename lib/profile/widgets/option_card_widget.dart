import 'package:bride_groom/profile/edit_profile/edit_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionCardWidget extends StatelessWidget {
  const OptionCardWidget({Key? key,
  required this.title,
  required this.icon,
    required this.index,
    this.user_data,
    this.logout,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final int index;
  final bool? logout;
  final Map<String, dynamic>? user_data;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(index == 1){
          Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileWidget(
            user_data: user_data,
          )));
        }
      },
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
                    icon,
                    color: logout == true ? Colors.red
                                          :Colors.purple,
                    size: 16.sp,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    title,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 14.sp),
                  ),
                ],
              ),
              IconButton(
                onPressed: (){

                },
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
