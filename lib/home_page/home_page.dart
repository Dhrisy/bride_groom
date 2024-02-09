import 'package:bride_groom/authentication/sign_up_page/provider.dart';
import 'package:bride_groom/home_page/widgets/onfocus_search_appbar.dart';
import 'package:bride_groom/home_page/widgets/profile_card_widget.dart';
import 'package:bride_groom/profile/profile_widget.dart';
import 'package:bride_groom/splash_screen/splashscreen_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/firebase_services.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required this.user_data,
  });

  final Map<String, dynamic>? user_data;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic>? user_data;

  final List<String> maleImageNames = [
    'assets/images/m1.jpg',
    'assets/images/m2.jpg',
    'assets/images/m3.jpg',
    'assets/images/m4.jpg',
    'assets/images/m5.jpg',
    // Add more male image names as needed
  ];

  final List<String> maleNames = [
    'John Doe',
    'Male User 2',
    'Amal',
    'Praveen',
    'Sudhir',
    // Add more male names as needed
  ];

  final List<String> femaleImageNames = [
    'assets/images/w1.jpg',
    'assets/images/w2.jpg',
    'assets/images/w3.jpg',
    'assets/images/w4.jpg',
    'assets/images/w5.jpg',

    // Add more female image names as needed
  ];

  final List<String> femaleNames = [
    'Jane Doe',
    'Female User 2',
    'vbn',
    'wertyu',
    'sdfgh'

    // Add more female names as needed
  ];

  String? userGender;

  Future<void> toCheckGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print('Email: ${prefs.getString('email')}');
    print('Gender: ${prefs.getString('gender')}');
    userGender = prefs.getString('gender');
    print(userGender);
  }

  late List<String> imageNames;
  late List<String> names;

  @override
  void initState() {
    super.initState();

    print(widget.user_data);
    toCheckGender();

    if (widget.user_data != null) {
      user_data = widget.user_data; // Assign the value
      print('NNNNNN');

      if (user_data!['gender'] == 'Bride') {
        print('ITS BRIDE');
        imageNames = maleImageNames;
        names = maleNames;
      } else {
        print('ITS GROOM');

        imageNames = femaleImageNames;
        names = femaleNames;
        // Debugging prints
        print('Length of imageNames: ${imageNames.length}');
        print('Length of names: ${names.length}');
      }
    } else {
      print('USER DATA IS NULL');
    }
  }

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      toCheckGender();
      // Navigate to the sign-in screen or any other screen after sign-out
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  Future<void> clearSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    print('${preferences.getString('email')},'
        '${preferences.getString('user_id')},'
        '${preferences.getString('phone')},'
        '${preferences.getString('password')},'
        '${preferences.getString('gender')},');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Perform your custom logic here

        // Exit the app when the back button is pressed
        SystemNavigator.pop();
        return false; // You can also return true to allow back navigation
      },
      child: Consumer<AppProvider>(builder: (context, provider, child) {
        return GestureDetector(
          onTap: () {
            print('kkkkkkk');
            FocusScope.of(context).unfocus();
            provider.setSearching(false);
          },
          child: Scaffold(
            appBar: provider.isSearching == false
                ? AppBar(
                    leadingWidth: 20,
                    iconTheme: IconThemeData(
                      color: Colors.purple,
                    ),

                    toolbarHeight: 60.h,
                    backgroundColor:
                        Colors.white, //Colors.purple.withOpacity(0.1),
                    centerTitle: true,
                    title: Container(
                      height: 60.h,
                      // color: Colors.purple.withOpacity(0.1),
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () async {
                                // await _signOut();
                                // clearSharedPreferences();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileWidget(
                                          user_data: widget.user_data,

                                        )));

                                // provider.setSearching(true);
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.purple
                                      .withOpacity(0.1), // Set the desired color
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                provider.setSearching(true);
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.purple
                                      .withOpacity(0.1), // Set the desired color
                                ),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                            Text(
                              'Find your Heart mate',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            Row(
                              children: [
                                Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.purple.withOpacity(
                                          0.1), // Set the desired color
                                    ),
                                    child: Icon(Icons.star_outlined)),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.purple.withOpacity(
                                          0.1), // Set the desired color
                                    ),
                                    child: Icon(Icons.filter_list)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : AppBar(
                    iconTheme: IconThemeData(
                      color: Colors.purple,
                    ),
                    toolbarHeight: 65.h,
                    backgroundColor: Colors.white,
                    centerTitle: true,
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(height: 65.h, child: OnFocusSearchAppBar()),
                    ),
                  ),
            body: Container(
              height: double.infinity,
              child: ListView.builder(
                itemCount: imageNames.length,
                itemBuilder: (BuildContext context, int index) {
                  return
                    Padding(
                    padding: EdgeInsets.only(bottom: 10.sp),
                    child: ProfileCard(
                      image: imageNames[index],
                      name: names[index],
                    ),
                  );
                },
              ),
            ),


          ),
        );
      }),
    );
  }
}
