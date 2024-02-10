// import 'package:bride_groom/authentication/sign_up_page/provider.dart';
// import 'package:bride_groom/home_page/widgets/onfocus_search_appbar.dart';
// import 'package:bride_groom/home_page/widgets/profile_card_widget.dart';
// import 'package:bride_groom/profile/profile_widget.dart';
// import 'package:bride_groom/splash_screen/splashscreen_widgets.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get_it/get_it.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../custom_functions/custom_functions.dart';
// import '../profile/opposite_gender_profile/oppopsite_gender_profile.dart';
// import '../services/firebase_services.dart';
// import 'home_page2.dart';
//
// class HomePage extends StatefulWidget {
//   HomePage({
//     super.key,
//     required this.user_data,
//   });
//
//   final Map<String, dynamic>? user_data;
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   Map<String, dynamic>? user_data;
//   String? userSearchLocation; // New variable for user's search location
//
//   String? userGender;
//   TextEditingController serach_controller = TextEditingController();
//
//   Future<void> toCheckGender() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     print('Email: ${prefs.getString('email')}');
//     print('Gender: ${prefs.getString('gender')}');
//     userGender = prefs.getString('gender');
//     print(userGender);
//   }
//
//   late List<String> imageNames;
//   late List<String> names;
//
//   String _gender = '';
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//
//     print(widget.user_data);
//     toCheckGender();
//
//     if (widget.user_data != null) {
//       user_data = widget.user_data; // Assign the value
//       print('NNNNNN');
//
//       if (user_data!['gender'] == 'Bride') {
//         print('ITS BRIDE');
//       } else {
//         print('ITS GROOM');
//       }
//     } else {
//       print('USER DATA IS NULL');
//     }
//   }
//
//   Future<void> clearSharedPreferences() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     await preferences.clear();
//     print('${preferences.getString('email')},'
//         '${preferences.getString('user_id')},'
//         '${preferences.getString('phone')},'
//         '${preferences.getString('password')},'
//         '${preferences.getString('gender')},');
//   }
//
//   Future<void> fetchData() async {
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .where('email', isEqualTo: widget.user_data!['email'])
//           .get();
//
//       if (querySnapshot.docs.isNotEmpty) {
//         // Data is available
//         var userData = querySnapshot.docs.first.data();
//         setState(() {
//           _gender = user_data!['gender'];
//         });
//         print('User Data: $userData');
//       } else {
//         // No data found
//         print('No user data found');
//       }
//     } catch (error) {
//       // Handle error
//       print('Error fetching user data: $error');
//     }
//   }
//
//   String? newCustomFunction(
//     String? searchitem,
//     String? listitems,
//   ) {
//     // the documents have ''location" , when searchitem conatins in document[''location]'retun doc
//     return listitems?.contains(searchitem!) == true ? listitems : null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('users').snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//               child: SizedBox(
//                 width: 50.0,
//                 height: 50.0,
//                 child: CircularProgressIndicator(
//                   color: Colors.black,
//                 ),
//               ),
//             );
//           }
//
//           List<DocumentSnapshot> filteredDocuments =
//               snapshot.data!.docs.where((document) {
//             print(
//                 'Document gender: ${document['gender']}, Selected gender: ${_gender},  ');
//             return document['gender'] != _gender;
//           }).toList();
//
//           return WillPopScope(
//             onWillPop: () async {
//               SystemNavigator.pop();
//               return false; // You can also return true to allow back navigation
//             },
//             child: Consumer<AppProvider>(builder: (context, provider, child) {
//               return Scaffold(
//                 appBar:
//                 // provider.isSearching == false
//                 //     ? AppBar(
//                 //         leadingWidth: 20,
//                 //         iconTheme: IconThemeData(
//                 //           color: Colors.purple,
//                 //         ),
//                 //
//                 //         toolbarHeight: 60.h,
//                 //         backgroundColor:
//                 //             Colors.white, //Colors.purple.withOpacity(0.1),
//                 //         centerTitle: true,
//                 //         title: Container(
//                 //           height: 60.h,
//                 //           // color: Colors.purple.withOpacity(0.1),
//                 //           child: Padding(
//                 //             padding: EdgeInsets.only(left: 5.w),
//                 //             child: Row(
//                 //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //               children: [
//                 //                 InkWell(
//                 //                   onTap: () async {
//                 //                     // await _signOut();
//                 //                     // clearSharedPreferences();
//                 //                     Navigator.push(
//                 //                       context,
//                 //                       PageRouteBuilder(
//                 //                         pageBuilder: (context, animation,
//                 //                                 secondaryAnimation) =>
//                 //                             ProfileWidget(
//                 //                           user_data: widget.user_data,
//                 //                         ),
//                 //                         transitionsBuilder: (context, animation,
//                 //                             secondaryAnimation, child) {
//                 //                           var curve = Curves.fastOutSlowIn;
//                 //
//                 //                           return FadeTransition(
//                 //                             opacity: animation.drive(
//                 //                                 CurveTween(curve: curve)),
//                 //                             child: child,
//                 //                           );
//                 //                         },
//                 //                       ),
//                 //                     );
//                 //
//                 //                     // provider.setSearching(true);
//                 //                   },
//                 //                   child: Container(
//                 //                     height: 40,
//                 //                     width: 40,
//                 //                     decoration: BoxDecoration(
//                 //                       shape: BoxShape.circle,
//                 //                       color: Colors.purple.withOpacity(
//                 //                           0.1), // Set the desired color
//                 //                     ),
//                 //                     child: Icon(
//                 //                       Icons.person,
//                 //                       color: Colors.purple,
//                 //                     ),
//                 //                   ),
//                 //                 ),
//                 //                 InkWell(
//                 //                   onTap: () {
//                 //                     provider.setSearching(true);
//                 //                   },
//                 //                   child: Container(
//                 //                     height: 40,
//                 //                     width: 40,
//                 //                     decoration: BoxDecoration(
//                 //                       shape: BoxShape.circle,
//                 //                       color: Colors.purple.withOpacity(
//                 //                           0.1), // Set the desired color
//                 //                     ),
//                 //                     child: Icon(
//                 //                       Icons.search,
//                 //                       color: Colors.purple,
//                 //                     ),
//                 //                   ),
//                 //                 ),
//                 //                 Text(
//                 //                   'Find your Heart mate',
//                 //                   style: TextStyle(fontSize: 16.sp),
//                 //                 ),
//                 //                 Row(
//                 //                   children: [
//                 //                     Container(
//                 //                         height: 40,
//                 //                         width: 40,
//                 //                         decoration: BoxDecoration(
//                 //                           shape: BoxShape.circle,
//                 //                           color: Colors.purple.withOpacity(
//                 //                               0.1), // Set the desired color
//                 //                         ),
//                 //                         child: Icon(Icons.star_outlined)),
//                 //                     SizedBox(
//                 //                       width: 5.w,
//                 //                     ),
//                 //                     Container(
//                 //                         height: 40,
//                 //                         width: 40,
//                 //                         decoration: BoxDecoration(
//                 //                           shape: BoxShape.circle,
//                 //                           color: Colors.purple.withOpacity(
//                 //                               0.1), // Set the desired color
//                 //                         ),
//                 //                         child: Icon(Icons.filter_list)),
//                 //                   ],
//                 //                 ),
//                 //               ],
//                 //             ),
//                 //           ),
//                 //         ),
//                 //       )
//                 //     :
//                 AppBar(
//                         iconTheme: IconThemeData(
//                           color: Colors.purple,
//                         ),
//                         toolbarHeight: 65.h,
//                         backgroundColor: Colors.white,
//                         centerTitle: true,
//                         title: Padding(
//                           padding: const EdgeInsets.only(bottom: 5),
//                           child: Container(
//                             height: 65.h,
//                             child: Row(
//                               children: [
//                                 SizedBox(
//                                   width: 5.w,
//                                 ),
//                                 Expanded(
//                                     child: Container(
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                       color: Colors.purple.withOpacity(0.1),
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(10.r))),
//                                   child: TextFormField(
//                                     decoration: InputDecoration(
//                                       border: InputBorder.none,
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                           color: Colors
//                                               .blue, // Set your desired border color
//                                           width: 2.0, // Set the border width
//                                         ),
//                                         borderRadius:
//                                             BorderRadius.circular(10.0),
//                                       ),
//                                       filled: true,
//                                       fillColor: Colors.transparent,
//                                       hintText: 'Enter text',
//                                       labelText: 'Label',
//                                     ),
//                                   ),
//                                 )),
//                                 TextButton(
//                                   onPressed: () {
//                                     // provider.setSearching(false);
//                                     // search_controller.clear();
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 SearchScreen()));
//                                   },
//                                   child: Container(
//                                       height: 40,
//                                       width: 40,
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: Colors.purple.withOpacity(
//                                             0.1), // Set the desired color
//                                       ),
//                                       child: Icon(Icons.close)),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                 body: InkWell(
//                     onTap: (){
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => TestHomePage(user_data: user_data)));
//                     },
//                     child: Text('sdfghj'))
//                 // SingleChildScrollView(
//                 //   child: Column(
//                 //     children: [
//                 //       ListView.builder(
//                 //         padding: EdgeInsets.zero,
//                 //         shrinkWrap: true,
//                 //         scrollDirection: Axis.vertical,
//                 //         itemCount: filteredDocuments.length,
//                 //         itemBuilder: (context, listVieSearchIndex) {
//                 //           final listVieSearchJobsRecord =
//                 //               filteredDocuments[listVieSearchIndex];
//                 //           print('gggg${listVieSearchJobsRecord['location']}');
//                 //
//                 //           return Column(
//                 //             mainAxisSize: MainAxisSize.max,
//                 //             children: [
//                 //               if (search(serach_controller.text,
//                 //                       listVieSearchJobsRecord['location']) ??
//                 //                   true)
//                 //                 Padding(
//                 //                   padding: const EdgeInsets.only(
//                 //                       top: 20, right: 20, left: 20),
//                 //                   child: InkWell(
//                 //                     onTap: () {
//                 //                       Navigator.push(
//                 //                           context,
//                 //                           MaterialPageRoute(
//                 //                               builder: (context) =>
//                 //                                   OppositeGenderProfile()));
//                 //                     },
//                 //                     child: Container(
//                 //                       height: 350.h,
//                 //                       // width: 0.w,
//                 //                       decoration: BoxDecoration(
//                 //                         color: Colors.white,
//                 //                         borderRadius: BorderRadius.all(
//                 //                             Radius.circular(20.r)),
//                 //                         boxShadow: [
//                 //                           BoxShadow(
//                 //                             color: Colors.grey.withOpacity(0.2),
//                 //                             spreadRadius: 1.2,
//                 //                             blurRadius: 5,
//                 //                             offset: Offset(1, 1),
//                 //                           ),
//                 //                         ],
//                 //                       ),
//                 //                       child: Column(
//                 //                         children: [
//                 //                           Container(
//                 //                             width: double.infinity,
//                 //                             child: ClipRRect(
//                 //                               borderRadius: BorderRadius.only(
//                 //                                   topLeft:
//                 //                                       Radius.circular(13.r),
//                 //                                   topRight: Radius.circular(13
//                 //                                       .r)), // Set the desired border radius
//                 //                               child:
//                 //                               // listVieSearchJobsRecord[
//                 //                               //         'image']
//                 //                               //     ? SizedBox(
//                 //                               //         height: 20.r,
//                 //                               //         width: 20.r,
//                 //                               //         child:
//                 //                               //             CircularProgressIndicator(
//                 //                               //                 color:
//                 //                               //                     Colors.white),
//                 //                               //       )
//                 //                               //     :
//                 //                                   // widget.image != null && widget.image != ''
//                 //                                   // ? Image.network(
//                 //                                   //   widget.image,
//                 //                                   //   // widget.image,
//                 //                                   //   height: 250.h,
//                 //                                   //   width: 150.w,
//                 //                                   //   fit: BoxFit.cover,
//                 //                                   // )
//                 //                                   //     :
//                 //                                   Image.asset(
//                 //                                       'assets/images/default_profile.jpg',
//                 //                                       // widget.image,
//                 //                                       height: 250.h,
//                 //                                       width: 150.w,
//                 //                                       fit: BoxFit.cover,
//                 //                                     ),
//                 //                             ),
//                 //                           ),
//                 //                           SizedBox(
//                 //                             height: 10.h,
//                 //                           ),
//                 //                           Row(
//                 //                             mainAxisAlignment:
//                 //                                 MainAxisAlignment.spaceBetween,
//                 //                             children: [
//                 //                               Row(
//                 //                                 mainAxisAlignment:
//                 //                                     MainAxisAlignment.start,
//                 //                                 crossAxisAlignment:
//                 //                                     CrossAxisAlignment.center,
//                 //                                 children: [
//                 //                                   Padding(
//                 //                                       padding:
//                 //                                           const EdgeInsets.only(
//                 //                                               left: 5,
//                 //                                               right: 10),
//                 //                                       child: listVieSearchJobsRecord[
//                 //                                                       'image'] !=
//                 //                                                   null ||
//                 //                                               listVieSearchJobsRecord[
//                 //                                                       'image'] !=
//                 //                                                   ''
//                 //                                           ? Container(
//                 //                                               height: 40,
//                 //                                               width: 40,
//                 //                                               decoration:
//                 //                                                   BoxDecoration(
//                 //                                                 shape: BoxShape
//                 //                                                     .circle,
//                 //                                                 color: Colors
//                 //                                                     .purple
//                 //                                                     .withOpacity(
//                 //                                                         0.1),
//                 //                                                 image:
//                 //                                                     DecorationImage(
//                 //                                                   image: NetworkImage(
//                 //                                                       listVieSearchJobsRecord[
//                 //                                                           'image']), // Replace 'assets/your_image.png' with the actual path to your image
//                 //                                                   fit: BoxFit
//                 //                                                       .cover, // You can adjust the fit based on your requirements
//                 //                                                 ),
//                 //                                               ),
//                 //                                             )
//                 //                                           : Container(
//                 //                                               height: 40,
//                 //                                               width: 40,
//                 //                                               decoration:
//                 //                                                   BoxDecoration(
//                 //                                                 shape: BoxShape
//                 //                                                     .circle,
//                 //                                                 color: Colors
//                 //                                                     .purple
//                 //                                                     .withOpacity(
//                 //                                                         0.1),
//                 //                                                 image:
//                 //                                                     DecorationImage(
//                 //                                                   image: AssetImage(
//                 //                                                       'assets/images/default_profile.jpg'), // Replace 'assets/your_image.png' with the actual path to your image
//                 //                                                   fit: BoxFit
//                 //                                                       .cover, // You can adjust the fit based on your requirements
//                 //                                                 ),
//                 //                                               ),
//                 //                                             )),
//                 //                                   Column(
//                 //                                     crossAxisAlignment:
//                 //                                         CrossAxisAlignment
//                 //                                             .start,
//                 //                                     mainAxisAlignment:
//                 //                                         MainAxisAlignment.start,
//                 //                                     mainAxisSize:
//                 //                                         MainAxisSize.max,
//                 //                                     children: [
//                 //                                       Text(
//                 //                                         listVieSearchJobsRecord[
//                 //                                             'name'],
//                 //                                         style: TextStyle(
//                 //                                             fontSize: 18.sp,
//                 //                                             fontWeight:
//                 //                                                 FontWeight
//                 //                                                     .w500),
//                 //                                       ),
//                 //                                       Text(
//                 //                                         listVieSearchJobsRecord['location'],
//                 //                                         style: TextStyle(
//                 //                                             fontSize: 14.sp),
//                 //                                       ),
//                 //                                       Text(
//                 //                                         'height : 100',
//                 //                                         style: TextStyle(
//                 //                                             fontSize: 14.sp),
//                 //                                       ),
//                 //                                       Text(
//                 //                                         'weight: 40',
//                 //                                         style: TextStyle(
//                 //                                             fontSize: 14.sp),
//                 //                                       )
//                 //                                     ],
//                 //                                   ),
//                 //                                 ],
//                 //                               ),
//                 //                               Icon(Icons.more_vert_outlined)
//                 //                             ],
//                 //                           ),
//                 //                         ],
//                 //                       ),
//                 //                     ),
//                 //                   ),
//                 //                 )
//                 //             ],
//                 //           );
//                 //         },
//                 //       )
//                 //     ],
//                 //   ),
//                 // ),
//               );
//             }),
//           );
//         });
//   }
// }
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   List<String> data = [
//     'Apple',
//     'Banana',
//     'Cherry',
//     'Date',
//     'Elderberry',
//     'Fig',
//     'Grapes',
//     'Honeydew',
//     'Kiwi',
//     'Lemon',
//   ];
//
//   List<String> searchResults = [];
//   void onQueryChanged(String query) {
//     setState(() {
//       searchResults = data
//           .where((item) => item.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Search Bar Tutorial'),
//       ),
//       body: Column(
//         children: [
//           SerachBar(onQueryChanged: onQueryChanged),
//           Expanded(
//             child: ListView.builder(
//               itemCount: searchResults.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(searchResults[index]),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class SerachBar extends StatefulWidget {
//   SerachBar({
//     Key? key,
//     required void Function(String query) onQueryChanged,
//   }) : super(key: key);
//
//   @override
//   State<SerachBar> createState() => _SerachBarState();
// }
//
// class _SerachBarState extends State<SerachBar> {
//   String query = '';
//
//   void onQueryChanged(String newQuery) {
//     setState(() {
//       query = newQuery;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: TextField(
//         onChanged: onQueryChanged,
//         decoration: InputDecoration(
//           labelText: 'Search',
//           border: OutlineInputBorder(),
//           prefixIcon: Icon(Icons.search),
//         ),
//       ),
//     );
//   }
// }
