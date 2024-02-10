import 'package:bride_groom/authentication/sign_up_page/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custom_functions/custom_functions.dart';
import '../profile/opposite_gender_profile/oppopsite_gender_profile.dart';
import '../profile/profile_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.user_data,
  }) : super(key: key);
  final Map<String, dynamic>? user_data;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _gender = '';
  Map<String, dynamic>? user_data;
  TextEditingController serach_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();

    // if (widget.user_data != null) {
    //   print('iiiii${widget.user_data!['gender']}');
    //
    //   user_data = widget.user_data; // Assign the value
    //   print('NNNNNN');

    //   if (user_data!['gender'] == 'Bride') {
    //     print('ITS BRIDE');
    //     // imageNames = maleImageNames;
    //     // names = maleNames;
    //   } else {
    //     print('ITS GROOM');
    //
    //     // imageNames = femaleImageNames;
    //     // names = femaleNames;
    //     // // Debugging prints
    //     // print('Length of imageNames: ${imageNames.length}');
    //     // print('Length of names: ${names.length}');
    //   }
    // } else {
    //   print('USER DATA IS NULL');
    // }
  }

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('user_id');

    try {

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('user_id', isEqualTo: prefs.getString('user_id'))
          .get();

      print('Documents from Firestore: ${querySnapshot.docs}');
      print('Number of documents: ${querySnapshot.size}');

      if (querySnapshot.docs.isNotEmpty) {


        // Data is available
        var userData = querySnapshot.docs.first.data();
        setState(() {
          _gender = user_data!['gender'];
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').where('gender', isNotEqualTo:  _gender).snapshots(),
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
                'Document gender: ${document['gender']}, Selected gender: ${_gender},  ');
            return document['gender'] != _gender;
          }).toList();
          print('SNAPSHOT: ${snapshot.data?.size}');

          return SafeArea(
            child: Scaffold(

                body: GestureDetector(
              child: Consumer<AppProvider>(builder: (context, provider, child) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    provider.isSearching == false ?
                    AppBar(
                      automaticallyImplyLeading: false,

                      leadingWidth: 20,
                      iconTheme: IconThemeData(
                        color: Colors.purple,
                      ),

                      toolbarHeight: 60.h,
                      backgroundColor: Colors.white, //Colors.purple.withOpacity(0.1),
                      centerTitle: true,
                      title: Container(
                        height: 60.h,
                        color: Colors.transparent,//Colors.purple.withOpacity(0.1),
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
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                          ProfileWidget(
                                            user_data: widget.user_data,
                                          ),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        var curve = Curves.fastOutSlowIn;

                                        return FadeTransition(
                                          opacity: animation.drive(
                                              CurveTween(curve: curve)),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );

                                  // provider.setSearching(true);
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.purple.withOpacity(
                                        0.1), // Set the desired color
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
                                    color: Colors.purple.withOpacity(0.1), // Set the desired color
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
                      automaticallyImplyLeading: false,
                      iconTheme: IconThemeData(
                        color: Colors.purple,
                      ),
                      toolbarHeight: 70.h,
                      backgroundColor: Colors.transparent,
                      centerTitle: true,
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 20, top: 20),
                        child: Container(
                          height: 65.h,
                          child:   Row(
                            children: [
                              SizedBox(
                                width: 5.w,
                              ),
                              Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.purple.withOpacity(0.1),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10.r))),
                                    child: TextFormField(
                                      onChanged: (val) {
                                        provider.setSearch(serach_controller.text);
                                        print('bbbb${val},   ${provider.search}');
                                      },
                                      controller: serach_controller,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors
                                                .blue, // Set your desired border color
                                            width: 2.0, // Set the border width
                                          ),
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        hintText: 'Search by location',
                                        labelText: 'Search',
                                      ),
                                    ),
                                  )),
                              TextButton(
                                onPressed: () {
                                  provider.setSearching(false);
                                  serach_controller.clear();
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.purple.withOpacity(
                                          0.1), // Set the desired color
                                    ),
                                    child: Icon(Icons.close)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [

                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.0, 10.0, 15.0, 0.0),
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: filteredDocuments.length,
                                          itemBuilder:
                                              (context, listVieSearchIndex) {
                                            print(
                                                'ccccc${filteredDocuments.length}');
                                            final listVieSearchJobsRecord =
                                                filteredDocuments[
                                                    listVieSearchIndex];
                                            print('gggg${listVieSearchJobsRecord['image']}');

                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                if (search(
                                                        provider.search,
                                                        listVieSearchJobsRecord[
                                                            'location']) ??
                                                    true)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 0,
                                                            right: 0,
                                                            left: 0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    OppositeGenderProfile(
                                                                      userData: listVieSearchJobsRecord
                                                                    )));
                                                      },
                                                      child: Container(
                                                        height: 350.h,
                                                        // width: 0.w,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      20.r)),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.2),
                                                              spreadRadius: 1.2,
                                                              blurRadius: 5,
                                                              offset:
                                                                  Offset(1, 1),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              width:
                                                                  double.infinity,
                                                              child: ClipRRect(
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            13.r),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            13.r)), // Set the desired border radius
                                                                child:
                                                                    listVieSearchJobsRecord['image'] != null && listVieSearchJobsRecord['image'] != ''
                                                                    ? Image.network(
                                                                      listVieSearchJobsRecord['image'],
                                                                      // widget.image,
                                                                      height: 250.h,
                                                                      width: 150.w,
                                                                      fit: BoxFit.cover,
                                                                    )
                                                                        :
                                                                    Image.asset(
                                                                  'assets/images/default_profile.jpg',
                                                                  // widget.image,
                                                                  height: 250.h,
                                                                  width: 150.w,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                5,
                                                                            right:
                                                                                10),
                                                                        child: listVieSearchJobsRecord['image'] != null ||
                                                                                listVieSearchJobsRecord['image'] != ''
                                                                            ? Container(
                                                                                height: 40,
                                                                                width: 40,
                                                                                decoration: BoxDecoration(
                                                                                  shape: BoxShape.circle,
                                                                                  color: Colors.purple.withOpacity(0.1),
                                                                                  image: DecorationImage(
                                                                                    image: NetworkImage(listVieSearchJobsRecord['image']), // Replace 'assets/your_image.png' with the actual path to your image
                                                                                    fit: BoxFit.cover, // You can adjust the fit based on your requirements
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            : Container(
                                                                                height: 40,
                                                                                width: 40,
                                                                                decoration: BoxDecoration(
                                                                                  shape: BoxShape.circle,
                                                                                  color: Colors.purple.withOpacity(0.1),
                                                                                  image: DecorationImage(
                                                                                    image: AssetImage('assets/images/default_profile.jpg'), // Replace 'assets/your_image.png' with the actual path to your image
                                                                                    fit: BoxFit.cover, // You can adjust the fit based on your requirements
                                                                                  ),
                                                                                ),
                                                                              )),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Text(
                                                                          listVieSearchJobsRecord[
                                                                              'name'],
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  18.sp,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                        Text(
                                                                          listVieSearchJobsRecord[
                                                                              'location'],
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  14.sp),
                                                                        ),
                                                                        Text(
                                                                          'height : 100',
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  14.sp),
                                                                        ),
                                                                        Text(
                                                                          'weight: 40',
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  14.sp),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                Icon(Icons
                                                                    .more_vert_outlined)
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                              ],
                                            );
                                          },
                                        )


                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            )),
          );
        });
  }
}
