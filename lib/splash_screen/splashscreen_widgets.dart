import 'dart:async';
import 'package:bride_groom/authentication/entry_page.dart';
import 'package:bride_groom/authentication/sign_up_page/provider.dart';
import 'package:bride_groom/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/firebase_services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  String? user_id;
  String email = '';
  Map<String, dynamic>? user_data;



  @override
  void initState() {
    super.initState();
    // fetUseData();
   _initialize();
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



  }

  Future<String> getEmail() async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      user_id = prefs.getString('user_id').toString();
      final Email =   prefs.getString('email');
      email = Email!;
      setState(() {
        email = Email;
      });
      print('user_id: ${prefs.getString('user_id')}');

      return Email;
    }catch(e){
      print(e);
      return '';
    }
  }

  void fetUseData( String email) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseServices _firebase_services = GetIt.I.get<FirebaseServices>();
    user_data = await _firebase_services.getUserDataByEmail(email);
  }

  Future<void> _initialize() async {
    await getEmail();
    if (email != '') {
      fetUseData(email);
      Timer(
        Duration(seconds: 4),
            () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              user_data: user_data,
            ),
          ),
        ),
      );
    } else {
      Timer(
        Duration(seconds: 4),
            () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EntryPage()),
        ),
      );
    }

    // ... rest of your initState code
  }


  @override
  Widget build(BuildContext context) {
    AppProvider myProvider = Provider.of<AppProvider>(context);
    print(myProvider.Email);

    return Scaffold(
      backgroundColor: Colors.purple, // Set your preferred background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animation.value,
                  child: child,
                );
              },
              child: Image.asset(
                'assets/images/ring.png',
                height: 100.h,
                width: 100.h,
              ),
            ),

            SizedBox(height: 20.0),
            Text('sdfghjm'),

            // Your app name or tagline
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
