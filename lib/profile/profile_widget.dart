import 'package:bride_groom/profile/widgets/option_card_widget.dart';
import 'package:bride_groom/profile/widgets/user_card.dart';
import 'package:bride_groom/splash_screen/splashscreen_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../authentication/provider/provider.dart';
import '../home_page/home_page2.dart';
import '../services/firebase_services.dart';
import 'edit_profile/edit_profile_widget.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    Key? key,
    this.userId,
    required this.user_data,
  }) : super(key: key);

  final Map<String, dynamic>? user_data;
  final String? userId;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget>
    with TickerProviderStateMixin {
  late TabController tabBarController;
  Map<String, dynamic>? fetch_data;
  String? user_id;

  Future<Map<String, dynamic>?> getUserDataByEmail(String email) async {
    try {
      // Reference to the 'users' collection
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      // Query for the document with the matching email
      QuerySnapshot querySnapshot =
          await usersCollection.where('email', isEqualTo: email).get();

      // Check if a document is found
      if (querySnapshot.docs.isNotEmpty) {
        print('hhhhhhh');

        // Return the data of the first document found (assuming emails are unique)
        return querySnapshot.docs.first.data() as Map<String, dynamic>;
      } else {
        print('jjjjj');
        // If no document is found, return null
        return null;
      }
    } catch (e) {
      // Handle any potential errors during the process
      print('Error fetching user data: $e');
      return null;
    }
  }

  void fetch() async {
    FirebaseServicesWidget _firebase_services = GetIt.I.get<FirebaseServicesWidget>();
    Map<String, dynamic>? userData =
        await _firebase_services.getUserDataByEmail(widget.user_data!['email']);
    if (userData != null) {
      setState(() {
        fetch_data = userData;
      });
      print('User_data: $userData,   ${fetch_data}');
    } else {
      print('User not found');
    }
  }

  @override
  void initState() {
    super.initState();
    print('${widget.user_data},  ${widget.userId}');
    fetch();
    // fetchData();
    tabBarController = TabController(
      vsync: this,
      length: 2,
    );
  }

  // Future<void> fetchData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.getString('user_id');
  //   user_id = prefs.getString('user_id');
  //
  //   if(user_id == null || user_id == ''){
  //     print('USER ID NULL');
  //   }else{
  //     print('USER not null');
  //   }
  //   try {
  //     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //         .collection('users')
  //         .where('user_id', isEqualTo: widget.userId)
  //         .get();
  //
  //     if (querySnapshot.docs.isNotEmpty) {
  //       // Data is available
  //       var userData = querySnapshot.docs.first.data();
  //       setState(() {
  //         fetch_data = userData as Map<String, dynamic>?;
  //       });
  //       print('User Data: $userData,  $fetch_data');
  //     } else {
  //       // No data found
  //       print('No user data found');
  //     }
  //   } catch (error) {
  //     // Handle error
  //     print('Error fetching user data: $error');
  //   }
  // }



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: fetch_data != null
            ? FirebaseFirestore.instance
            .collection('users')
            .where('user_id', isEqualTo: fetch_data!['user_id'])
            .limit(1)
            .snapshots()
            : null,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            );
          }

          Map<String, dynamic>? userData = snapshot.data!.docs.first.data() as Map<String, dynamic>;
          print('snapshot:   ${userData},');



          // // Access the data
          // QuerySnapshot querySnapshot = snapshot.data!;
          // List<QueryDocumentSnapshot> documents = querySnapshot.docs;
          //
          // //access data from  documents
          // for (QueryDocumentSnapshot document in documents) {
          //   Map<String, dynamic>? userData = document.data() as Map<String, dynamic>;
          //   // fetching each field
          //   print(userData['name']);
          //   print(userData['email']);
          // }
          // QueryDocumentSnapshot document = documents.first;
          // Map<String, dynamic> userData = document.data() as Map<String, dynamic>;
          // print('snapshot ${userData}');

          return WillPopScope(
            onWillPop: () async {
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage( )));
              return true; // allow back navigation
            },
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(

                  title: Text(
                    'User profile',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                body:
                    Consumer<AppProvider>(builder: (context, provider, child) {
                  return Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        children: [
                          // Check if fetch_data is available
                          UserCard(
                            isLoading: true,
                            user_data: fetch_data,
                          ),
                          // userCard(context),
                          // tabBar(context),
                          SizedBox(
                            height: 20.h,
                          ),
                          OptionCardWidget(
                            callback: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      EditProfileWidget(
                                    user_data: fetch_data,
                                  ),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    var curve = Curves.fastOutSlowIn;
                                    return FadeTransition(
                                      opacity: animation
                                          .drive(CurveTween(curve: curve)),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            user_data: fetch_data,
                            index: 1,
                            icon: Icons.person,
                            title: 'View or Edit profile',
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          OptionCardWidget(
                            callback: () {},
                            index: 2,
                            icon: Icons.image,
                            title: 'Photos uploaded',
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          OptionCardWidget(
                            callback: () {},
                            index: 3,
                            icon: Icons.star,
                            title: 'Starred profile',
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          OptionCardWidget(
                            callback: () {},
                            index: 4,
                            icon: Icons.settings,
                            title: 'Settings',
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          OptionCardWidget(
                            index: 5,
                            icon: Icons.logout_rounded,
                            logout: true,
                            title: 'Logout',
                            callback: () {
                              print('yyyyy');
                              myAlert();
                              provider.clearData();
                              print('bbbbbbbbbb${provider.UserId}, ${provider.Email}');

                            },
                          ),
                        ],
                      )
                      );
                }),
              ),
            ),
          );
        });
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Do you want to logout?',
            textAlign: TextAlign.center,),
            content: Container(
              decoration: BoxDecoration(

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      //if user click this button, user can upload image from gallery
                      onPressed: () {
                        _signOut();
                        clearSharedPreferences();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SplashScreen()));
                        },
                      child: Text('Yes'),
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: ElevatedButton(
                      //if user click this button. user can upload image from camera
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('No'),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> clearSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    print('bbbbbbbbbbb${preferences.getString('email')},'
        '${preferences.getString('user_id')},'
        '${preferences.getString('phone')},'
        '${preferences.getString('password')},'
        '${preferences.getString('gender')},');

  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}
