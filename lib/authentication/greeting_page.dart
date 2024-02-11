import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import '../home_page/home_page2.dart';
import '../services/firebase_services.dart';

class GreetingPage extends StatefulWidget {
  const GreetingPage({Key? key,
  required this.email,
    required this.name,
  }) : super(key: key);

  final String email;
  final String name;

  @override
  State<GreetingPage> createState() => _GreetingPageState();
}

class _GreetingPageState extends State<GreetingPage> with SingleTickerProviderStateMixin{

  Map<String, dynamic>? user_data;
  late AnimationController _controller;

  //fetch  user data
  void fetUseData() async{
    FirebaseServicesWidget _firebase_services = GetIt.I.get<FirebaseServicesWidget>();
    user_data = await _firebase_services.getUserDataByEmail(widget.email);
  }

  @override
  void initState() {
    super.initState();
    fetUseData();
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
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200.w,
                    height: 200.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.asset('assets/images/waving_hand.gif',
                      ),
                    ),
                  ),
                ],
              ),
              _welcomeMessage(context)
            ],
          ),
        ));
  }


  _welcomeMessage(context){
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
                      fontWeight: FontWeight.normal
                  ),
                  children: <TextSpan>[

                    TextSpan(
                        text: widget.name,
                        style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.w600
                        )
                    )
                  ]
              ),


            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your Journey Begins Here...',
              style: TextStyle(
                  fontSize: 16.sp
              ),)
          ],
        )
      ],
    );
  }
}

