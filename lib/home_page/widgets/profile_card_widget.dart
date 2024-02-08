import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key,
    required this.image,
    required this.name,

  }) : super(key: key);

  final String image;
  final String name;


  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Container(


        height: 320.h,
        // width: 0.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1.2,
              blurRadius: 5,
              offset: Offset(1, 1),
            ),

          ],
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13.r),
                    topRight:
                        Radius.circular(13.r)), // Set the desired border radius
                child: Image.asset(
                  widget.image,
                  height: 250.h,
                  width: 150.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 10),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.purple.withOpacity(0.1),
                          image: DecorationImage(
                            image: AssetImage(widget.image), // Replace 'assets/your_image.png' with the actual path to your image
                            fit: BoxFit.cover, // You can adjust the fit based on your requirements
                          ),
                        ),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(
                          'Location',
                          style: TextStyle(
                              fontSize: 14.sp
                          ),
                        )
                      ],
                    ),

                  ],
                ),
                Icon(Icons.more_vert_outlined)
              ],
            ),

          ],
        ),
      ),
    );
  }
}
