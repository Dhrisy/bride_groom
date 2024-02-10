import 'dart:io';

import 'package:bride_groom/authentication/sign_up_page/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../custom_functions/custom_functions.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.user_data,
    this.isLoading,
  }) : super(key: key);

  final Map<String, dynamic>? user_data;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    print(user_data?['image']);
    return Consumer<AppProvider>(builder: (context, provider, child) {
      return Container(
          child: (user_data == null || user_data == '') && isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blue), // Customize the color
                  strokeWidth: 5.0, // Customize the stroke width
                ))
              : Column(
                  children: [
                    SizedBox(height: 10.h),
                    // if (user_data?['image'].isNotEmpty)
                      Container(
                        height: 100.h,
                        width: 100.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/default_profile.jpg'), // Add your image path
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    // if (user_data?['image'] != null &&
                    //     user_data?['image'] != '')
                    //   Container(
                    //     height: 100.h,
                    //     width: 100.h,
                    //     decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       image: DecorationImage(
                    //         image: FileImage(File(
                    //             provider.Photo!.path)), // Add your image path
                    //         fit: BoxFit.cover,
                    //       ),
                    //     ),
                    //   ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user_data?['name'] == null || user_data!['name'] == ''
                              ? 'Not available'
                              : toSentenceCase(user_data!['name']!),
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
                          color: Colors.purple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user_data?['email'] ?? 'Not available',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ));
    });
  }
}
