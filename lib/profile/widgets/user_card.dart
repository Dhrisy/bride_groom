import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../custom_functions/custom_functions.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key,
  required this.user_data}) : super(key: key);

  final Map<String, dynamic>? user_data;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [

          SizedBox(height: 10.h),
          Container(
            height: 100.h,
            width: 100.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/m3.jpg'), // Add your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                toSentenceCase(user_data!['name']),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Container(
            height: 35.h,
            decoration: BoxDecoration(
                color: Colors.purple
                    .withOpacity(0.1),
                borderRadius: BorderRadius.circular(20)
            ),
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user_data!['email'],
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
