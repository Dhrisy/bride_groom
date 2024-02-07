import 'package:bride_groom/authentication/bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/entry_image.jpeg',
                    height: 250.h,
                    width: 200.h,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'WELCOME',
                    style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.black),
                  ),
                  Text(
                    'Find your perfect one',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12.sp,
                        color: Colors.black),
                  )
                ],
              ),
              BottomWidget()
            ],
          ),
        ),
      ),
    );
  }
}
