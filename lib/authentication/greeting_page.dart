import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/firebase_services.dart';

class GreetingPage extends StatefulWidget {
  const GreetingPage({Key? key,
  required this.email,
  }) : super(key: key);

  final String email;
  @override
  State<GreetingPage> createState() => _GreetingPageState();
}

class _GreetingPageState extends State<GreetingPage> {

  Map<String, dynamic>? user_data;


  void fetUseData() async{
    print('hhhhhh');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseServices _firebase_services = GetIt.I.get<FirebaseServices>();
    user_data = await _firebase_services.getUserDataByEmail(widget.email);
    print('rrrrrrrrrrr${user_data}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetUseData();
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
                      shape: BoxShape.circle, // Set the shape to circle for a rounded container

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
                        text: 'Dhrisya',
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

