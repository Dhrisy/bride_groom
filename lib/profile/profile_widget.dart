import 'package:bride_groom/authentication/sign_up_page/provider.dart';
import 'package:bride_groom/custom_functions/custom_functions.dart';
import 'package:bride_groom/home_page/home_page.dart';
import 'package:bride_groom/profile/widgets/grid_view_images.dart';
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

import '../services/firebase_services.dart';
import 'edit_profile/edit_profile_widget.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    Key? key,
    required this.user_data,
  }) : super(key: key);

  final Map<String, dynamic>? user_data;

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
    FirebaseServices _firebase_services = GetIt.I.get<FirebaseServices>();
    Map<String, dynamic>? userData =
        await _firebase_services.getUserDataByEmail(widget.user_data!['email']);
    // await getUserDataByEmail(widget.user_data!['email']);

    if (userData != null) {
      setState(() {
        fetch_data = userData;
      });
      print('User data: $userData,   ${fetch_data}');
    } else {
      print('User not found');
    }
  }

  @override
  void initState() {
    super.initState();
    fetch();
    fetchData();

    tabBarController = TabController(
      vsync: this,
      length: 2,
    );
  }

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('user_id');
    user_id = prefs.getString('user_id');

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('user_id', isEqualTo: prefs.getString('user_id'))
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Data is available
        var userData = querySnapshot.docs.first.data();
        setState(() {
          fetch_data = userData as Map<String, dynamic>?;
        });
        print('User Data: $userData');
      } else {
        // No data found
        print('No user data found');
      }
    } catch (error) {
      // Handle error
      print('Error fetching user data: $error');
    }
  }

  // stream: FirebaseFirestore.instance.collection('users').where('user_id', isEqualTo: user_id).snapshots(),
  // builder: (context, snapshot) {
  // if (snapshot.hasError) {
  // return Center(
  // child: Text('Error: ${snapshot.error}'),
  // );
  // }
  // if (snapshot.connectionState == ConnectionState.waiting) {
  // return Center(
  // child: CircularProgressIndicator(),
  // );
  // }
  // // Access the first document that matches the condition
  // DocumentSnapshot document = snapshot.data!.docs.isNotEmpty
  // ? snapshot.data!.docs[0]
  //     : throw 'No document found.';
  // // Access data from the document
  // Map<String, dynamic> data = document.data() as Map<String, dynamic>;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('user_id', isEqualTo: user_id)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            );
          }

          List<DocumentSnapshot> filteredDocuments =
              snapshot.data!.docs.where((document) {
            print(
                'Document gender: ${document['user_id']}, Selected gender: ${user_id},  ');
            return document['user_id'] != user_id;


          }).toList();
          print('SNAPSHOT: ${filteredDocuments}');
          return WillPopScope(
            onWillPop: () async {
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage(user_data: widget.user_data)));
              return true; // You can also return true to allow back navigation
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
                            title: 'View profile',
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
                              _signOut();
                              clearSharedPreferences();
                              provider.clearData();

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SplashScreen()));
                            },
                          ),
                        ],
                      )
                      // return ListView.builder(
                      //   itemCount: documents.length,
                      //   itemBuilder: (context, index) {
                      //     // Access data from each document
                      //     Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
                      //
                      //     // return ListTile(
                      //     //   title: Text(data['user_id']),
                      //     //   // Add more widgets to display other fields or customize as needed
                      //     // );
                      //   },
                      // );

                      );
                }),
              ),
            ),
          );
        });
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

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // toCheckGender();
      // Navigate to the sign-in screen or any other screen after sign-out
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}
