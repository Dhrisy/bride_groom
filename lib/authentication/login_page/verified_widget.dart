import 'dart:async';

import 'package:bride_groom/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home_page/home_page2.dart';
import '../../services/firebase_services.dart';

class VerifiedCredential extends StatefulWidget {
  const VerifiedCredential({
    Key? key,
    required this.fullname,
    required this.email
  }) : super(key: key);

  final String fullname;
final String email;
  @override
  _VerifiedCredentialState createState() => _VerifiedCredentialState();
}

class _VerifiedCredentialState extends State<VerifiedCredential>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Map<String, dynamic>? user_data;



  void fetUseData() async{
    FirebaseServices _firebase_services = GetIt.I.get<FirebaseServices>();
    user_data = await _firebase_services.getUserDataByEmail(widget.email);
  }

  @override
  void initState() {
    super.initState();
    fetUseData();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Adjust the duration as needed
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
    _controller.forward();

    Timer(
      Duration(seconds: 3),
          () => Navigator.pushReplacement(
        context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => HomePage(
                user_data: user_data,
              ),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                var curve = Curves.fastOutSlowIn;

                return FadeTransition(
                  opacity: animation.drive(CurveTween(curve: curve)),
                  child: child,
                );
              },
            ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.asset('assets/images/clapping.gif'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            _welcomeMessage(context),
          ],
        ),
      ),
    );
  }

  _welcomeMessage(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text.rich(
              TextSpan(
                text: 'Hi! ',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.normal,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.fullname,
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Successfully verified',
              style: TextStyle(
                fontSize: 16.sp,
              ),
            )
          ],
        )
      ],
    );
  }
}
