import 'package:bride_groom/authentication/provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../custom_functions/custom_functions.dart';
import '../profile/opposite_gender_profile/oppopsite_gender_profile.dart';
import '../profile/profile_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
     this.user_data,
     this.userId,
  }) : super(key: key);
  final Map<String, dynamic>? user_data;
final String? userId;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _gender = '';
  String _userId = '';
  Map<String, dynamic>? user_data;
  TextEditingController serach_controller = TextEditingController();
  String? selectedHeight;
  String? selectedWeight;
  String? selectedAge;

  List<String> heightOptions = ['Short', 'Average', 'Tall'];
  List<String> weightOptions = ['Slim', 'Average', 'Athletic', 'Heavy'];

  @override
  void initState() {
    super.initState();
    fetchData();
  }



  Future<void> fetchData() async {

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('user_id', isEqualTo: widget.userId)
          .get();

      print('Documents from Firestore: ${querySnapshot.docs}');
      print('Number of documents: ${querySnapshot.size}');

      if (querySnapshot.docs.isNotEmpty && querySnapshot.docs.first.exists) {
        var userData = querySnapshot.docs.first.data() as Map<String, dynamic>?;

        if (userData != null) {
          setState(() {
            _gender = userData['gender'];
            _userId = userData['user_id'];
          });
          print('User Data: $_userId');
        } else {
          print('User data is null');
        }
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
    return Consumer<AppProvider>(builder: (context, provider, child) {
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('user_id', isNotEqualTo: widget.userId)
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
                  'Document gender: ${document['gender']}, Selected gender: ${_gender},  ');
              return document['gender'] != _gender;
            }).toList();
            print('SNAPSHOT: ${snapshot.data?.size}');

            return WillPopScope(
              onWillPop: () async {
                SystemNavigator.pop();
                return false; // You can also return true to allow back navigation
              },
              child: SafeArea(
                child: Scaffold(
                  body: GestureDetector(
                      onTap: () {
                        provider.setFilter(false);
                        print('is filter: ${provider.isFilter}');
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          provider.isSearching == false
                              ? AppBar(
                                  automaticallyImplyLeading: false,

                                  leadingWidth: 20,
                                  iconTheme: IconThemeData(
                                    color: Colors.purple,
                                  ),

                                  toolbarHeight: 60.h,
                                  backgroundColor: Colors.white,
                                  //Colors.purple.withOpacity(0.1),
                                  centerTitle: true,
                                  title: Container(
                                    height: 60.h,
                                    color: Colors.transparent,
                                    //Colors.purple.withOpacity(0.1),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 5.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                             InkWell(
                                               onTap: () async {
                                                 // await _signOut();
                                                 // clearSharedPreferences();
                                                 Navigator.push(
                                                   context,
                                                   PageRouteBuilder(
                                                     pageBuilder: (context,
                                                         animation,
                                                         secondaryAnimation) =>
                                                         ProfileWidget(
                                                           userId: widget.userId,
                                                           user_data: widget.user_data,
                                                         ),
                                                     transitionsBuilder: (context,
                                                         animation,
                                                         secondaryAnimation,
                                                         child) {
                                                       var curve =
                                                           Curves.fastOutSlowIn;

                                                       return FadeTransition(
                                                         opacity: animation.drive(
                                                             CurveTween(
                                                                 curve: curve)),
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
                                             SizedBox(width: 8.w,),
                                             InkWell(
                                               onTap: () {
                                                 provider.setSearching(true);
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
                                                   Icons.search,
                                                   color: Colors.purple,
                                                 ),
                                               ),
                                             ),
                                             SizedBox(width: 8.w,),

                                             Text(
                                               'Find your Heart mate',
                                               style: TextStyle(fontSize: 16.sp),
                                             ),
                                           ],
                                         ),
                                          Row(
                                            children: [

                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              provider.isFilter == false
                                                  ? InkWell(
                                                      onTap: () {
                                                        provider
                                                            .setFilter(true);
                                                        print(
                                                            'tttt${provider.isFilter}');
                                                      },
                                                      child: Container(
                                                          height: 40,
                                                          width: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.purple
                                                                .withOpacity(
                                                                    0.1), // Set the desired color
                                                          ),
                                                          child: Icon(Icons
                                                              .filter_list)),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        provider.resetFilter();
                                                        provider
                                                            .setFilter(false);
                                                      },
                                                      child: Container(
                                                          height: 40,
                                                          width: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.purple
                                                                .withOpacity(
                                                                    0.1), // Set the desired color
                                                          ),
                                                          child: Icon(
                                                              Icons.close)),
                                                    ),
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
                                    padding: const EdgeInsets.only(
                                        bottom: 20, top: 20),
                                    child: Container(
                                      height: 65.h,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Expanded(
                                              child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Colors.purple
                                                    .withOpacity(0.1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.r))),
                                            child: TextFormField(
                                              onChanged: (val) {
                                                provider.setSearch(
                                                    serach_controller.text);
                                                print(
                                                    'bbbb${val},   ${provider.search}');
                                              },
                                              controller: serach_controller,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.purple,
                                                      // Set your desired border color
                                                      width:
                                                          2.0, // Set the border width
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.transparent,
                                                  hintText:
                                                      'Search by location',
                                                  labelText: 'Search',
                                                  labelStyle: TextStyle(
                                                      color: Colors.black)),
                                            ),
                                          )),
                                          TextButton(
                                            onPressed: () {
                                              provider.setSearching(false);
                                              provider.setSearch('');
                                              serach_controller.clear();
                                              provider.setFilter(false);
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
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                provider.isFilter == true
                                    ? Column(
                                        children: [
                                          buildFilterDropdown('Height',
                                              heightOptions, selectedHeight),
                                          buildFilterDropdown('Weight',
                                              weightOptions, selectedWeight),

                                        ],
                                      )
                                    : SizedBox.shrink(),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      15.0, 10.0, 15.0, 0.0),
                                              child: ListView.builder(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    filteredDocuments.length,
                                                itemBuilder: (context, listVieSearchIndex) {

                                                  final listVieProfileRecord =
                                                      filteredDocuments[
                                                          listVieSearchIndex];


                                                  return Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      if ((CustomFunctions.search(
                                                                      serach_controller
                                                                          .text,
                                                          listVieProfileRecord[
                                                                          'location']) ??
                                                                  true) &&
                                                              provider.FilterOption ==
                                                                  '' ||
                                                          provider.FilterOption ==
                                                              null)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
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
                                                                              userData: listVieProfileRecord)));
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                // height: 350.h,
                                                                // width: 0.w,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20.r)),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.2),
                                                                      spreadRadius:
                                                                          1.2,
                                                                      blurRadius:
                                                                          5,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              1),
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(13.r),
                                                                            topRight: Radius.circular(13.r)),
                                                                        // Set the desired border radius
                                                                        child: listVieProfileRecord['image'] != null &&
                                                                            listVieProfileRecord['image'] != ''
                                                                            ? Image.network(
                                                                          listVieProfileRecord['image'],
                                                                                // widget.image,
                                                                                height: 250.h,
                                                                                width: 150.w,
                                                                                fit: BoxFit.cover,
                                                                              )
                                                                            : Image.asset(
                                                                                'assets/images/default_profile.jpg',
                                                                                // widget.image,
                                                                                height: 250.h,
                                                                                width: 150.w,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10.h,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Padding(
                                                                                padding: const EdgeInsets.only(left: 5, right: 10),
                                                                                child: listVieProfileRecord['image'] != null || listVieProfileRecord['image'] != ''
                                                                                    ? Container(
                                                                                        height: 40,
                                                                                        width: 40,
                                                                                        decoration: BoxDecoration(
                                                                                          shape: BoxShape.circle,
                                                                                          color: Colors.purple.withOpacity(0.1),
                                                                                          image: DecorationImage(
                                                                                            image: NetworkImage(listVieProfileRecord['image']),
                                                                                            // Replace 'assets/your_image.png' with the actual path to your image
                                                                                            fit: BoxFit.cover, // You can adjust the fit based on your requirements
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    :
                                                                                Container(
                                                                                        height: 40,
                                                                                        width: 40,
                                                                                        decoration: BoxDecoration(
                                                                                          shape: BoxShape.circle,
                                                                                          // color: Colors.transparent,
                                                                                          image: DecorationImage(
                                                                                            image: AssetImage('assets/images/default_profile.jpg'),
                                                                                            // fit: BoxFit.cover, // You can adjust the fit based on your requirements
                                                                                          ),
                                                                                        ),
                                                                                      )),
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Text(
                                                                                  listVieProfileRecord['name'],
                                                                                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                                                                                ),
                                                                                (listVieProfileRecord['location'] != 'Not available' && listVieProfileRecord['location'] != null)
                                                                                    ? Text(
                                                                                  'Location: ${listVieProfileRecord['location']}',
                                                                                        style: TextStyle(fontSize: 14.sp),
                                                                                      )
                                                                                    : Text('Location not available'),
                                                                                (listVieProfileRecord['age'] != 'Not available' && listVieProfileRecord['age'] != null)
                                                                                    ? Text(
                                                                                  'Age: ${listVieProfileRecord['age']}',
                                                                                        style: TextStyle(fontSize: 14.sp),
                                                                                      )
                                                                                    :Text('Age not available'),
                                                                                (listVieProfileRecord['height'] != 'Not available' && listVieProfileRecord['height'] != null)
                                                                                    ? Text(
                                                                                        'Height: ${listVieProfileRecord['height']}',
                                                                                        style: TextStyle(fontSize: 14.sp),
                                                                                      )
                                                                                    : Text('Height not available'),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),

                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10.h,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                      if ((CustomFunctions.search(
                                                                  provider
                                                                      .FilterOption,
                                                          listVieProfileRecord[
                                                                      'height']) ??
                                                              true) &&
                                                          provider.FilterOption !=
                                                              '' &&
                                                          provider.FilterOption !=
                                                              null)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
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
                                                                              userData: listVieProfileRecord)));
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                // height: 350.h,
                                                                // width: 0.w,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20.r)),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.2),
                                                                      spreadRadius:
                                                                          1.2,
                                                                      blurRadius:
                                                                          5,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              1),
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(13.r),
                                                                            topRight: Radius.circular(13.r)),
                                                                        // Set the desired border radius
                                                                        child: listVieProfileRecord['image'] != null &&
                                                                            listVieProfileRecord['image'] != ''
                                                                            ? Image.network(
                                                                          listVieProfileRecord['image'],
                                                                                // widget.image,
                                                                                height: 250.h,
                                                                                width: 150.w,
                                                                                fit: BoxFit.cover,
                                                                              )
                                                                            : Image.asset(
                                                                                'assets/images/default_profile.jpg',
                                                                                // widget.image,
                                                                                height: 250.h,
                                                                                width: 150.w,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10.h,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Padding(
                                                                                padding: const EdgeInsets.only(left: 5, right: 10),
                                                                                child: listVieProfileRecord['image'] != null || listVieProfileRecord['image'] != ''
                                                                                    ? Container(
                                                                                        height: 40,
                                                                                        width: 40,
                                                                                        decoration: BoxDecoration(
                                                                                          shape: BoxShape.circle,
                                                                                          color: Colors.purple.withOpacity(0.1),
                                                                                          image: DecorationImage(
                                                                                            image: NetworkImage(listVieProfileRecord['image']),
                                                                                            // Replace 'assets/your_image.png' with the actual path to your image
                                                                                            fit: BoxFit.cover, // You can adjust the fit based on your requirements
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    : Container(
                                                                                        height: 40,
                                                                                        width: 40,
                                                                                        decoration: BoxDecoration(
                                                                                          shape: BoxShape.circle,
                                                                                          // color: Colors.transparent,
                                                                                          image: DecorationImage(
                                                                                            image: AssetImage('assets/images/default_profile.jpg'),
                                                                                            fit: BoxFit.cover, // You can adjust the fit based on your requirements
                                                                                          ),
                                                                                        ),
                                                                                      )),
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Text(
                                                                                  listVieProfileRecord['name'],
                                                                                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                                                                                ),
                                                                                (listVieProfileRecord['location'] != '' && listVieProfileRecord['location'] != null)
                                                                                    ? Text(
                                                                                  listVieProfileRecord['location'],
                                                                                        style: TextStyle(fontSize: 14.sp),
                                                                                      )
                                                                                    : SizedBox.shrink(),
                                                                                (listVieProfileRecord['age'] != '' && listVieProfileRecord['age'] != null)
                                                                                    ? Text(
                                                                                  listVieProfileRecord['age'],
                                                                                        style: TextStyle(fontSize: 14.sp),
                                                                                      )
                                                                                    : SizedBox.shrink(),
                                                                                (listVieProfileRecord['height'] != '' && listVieProfileRecord['height'] != null)
                                                                                    ? Text(
                                                                                  listVieProfileRecord['height'],
                                                                                        style: TextStyle(fontSize: 14.sp),
                                                                                      )
                                                                                    : SizedBox.shrink(),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),

                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10.h,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                      if ((CustomFunctions.search(
                                                                  provider
                                                                      .FilterOption,
                                                          listVieProfileRecord[
                                                                      'weight']) ??
                                                              true) &&
                                                          provider.FilterOption !=
                                                              '' &&
                                                          provider.FilterOption !=
                                                              null)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
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
                                                                              userData: listVieProfileRecord)));
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                // height: 350.h,
                                                                // width: 0.w,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20.r)),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.2),
                                                                      spreadRadius:
                                                                          1.2,
                                                                      blurRadius:
                                                                          5,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              1),
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(13.r),
                                                                            topRight: Radius.circular(13.r)),
                                                                        // Set the desired border radius
                                                                        child: listVieProfileRecord['image'] != null &&
                                                                            listVieProfileRecord['image'] != ''
                                                                            ? Image.network(
                                                                          listVieProfileRecord['image'],
                                                                                // widget.image,
                                                                                height: 250.h,
                                                                                width: 150.w,
                                                                                fit: BoxFit.cover,
                                                                              )
                                                                            : Image.asset(
                                                                                'assets/images/default_profile.jpg',
                                                                                // widget.image,
                                                                                height: 250.h,
                                                                                width: 150.w,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10.h,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Padding(
                                                                                padding: const EdgeInsets.only(left: 5, right: 10),
                                                                                child: listVieProfileRecord['image'] != null || listVieProfileRecord['image'] != ''
                                                                                    ? Container(
                                                                                        height: 40,
                                                                                        width: 40,
                                                                                        decoration: BoxDecoration(
                                                                                          shape: BoxShape.circle,
                                                                                          color: Colors.purple.withOpacity(0.1),
                                                                                          image: DecorationImage(
                                                                                            image: NetworkImage(listVieProfileRecord['image']),
                                                                                            // Replace 'assets/your_image.png' with the actual path to your image
                                                                                            fit: BoxFit.cover, // You can adjust the fit based on your requirements
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    : Container(
                                                                                        height: 40,
                                                                                        width: 40,
                                                                                        decoration: BoxDecoration(
                                                                                          shape: BoxShape.circle,
                                                                                          // color: Colors.transparent,
                                                                                          image: DecorationImage(
                                                                                            image: AssetImage('assets/images/default_profile.jpg'),
                                                                                            fit: BoxFit.cover, // You can adjust the fit based on your requirements
                                                                                          ),
                                                                                        ),
                                                                                      )),
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Text(
                                                                                  listVieProfileRecord['name'],
                                                                                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                                                                                ),
                                                                                (listVieProfileRecord['location'] != '' && listVieProfileRecord['location'] != null)
                                                                                    ? Text(
                                                                                  listVieProfileRecord['location'],
                                                                                        style: TextStyle(fontSize: 14.sp),
                                                                                      )
                                                                                    : SizedBox.shrink(),
                                                                                (listVieProfileRecord['age'] != '' && listVieProfileRecord['age'] != null)
                                                                                    ? Text(
                                                                                  listVieProfileRecord['age'],
                                                                                        style: TextStyle(fontSize: 14.sp),
                                                                                      )
                                                                                    : SizedBox.shrink(),
                                                                                (listVieProfileRecord['height'] != '' && listVieProfileRecord['height'] != null)
                                                                                    ? Text(
                                                                                  listVieProfileRecord['height'],
                                                                                        style: TextStyle(fontSize: 14.sp),
                                                                                      )
                                                                                    : SizedBox.shrink(),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),

                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10.h,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      if ((CustomFunctions.search(
                                                                  provider
                                                                      .FilterOption,
                                                          listVieProfileRecord[
                                                                      'age']) ??
                                                              true) &&
                                                          provider.FilterOption !=
                                                              '' &&
                                                          provider.FilterOption !=
                                                              null)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
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
                                                                              userData: listVieProfileRecord)));
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                // height: 350.h,
                                                                // width: 0.w,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20.r)),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.2),
                                                                      spreadRadius:
                                                                          1.2,
                                                                      blurRadius:
                                                                          5,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              1),
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(13.r),
                                                                            topRight: Radius.circular(13.r)),
                                                                        // Set the desired border radius
                                                                        child: listVieProfileRecord['image'] != null &&
                                                                            listVieProfileRecord['image'] != ''
                                                                            ? Image.network(
                                                                          listVieProfileRecord['image'],
                                                                                // widget.image,
                                                                                height: 250.h,
                                                                                width: 150.w,
                                                                                fit: BoxFit.cover,
                                                                              )
                                                                            : Image.asset(
                                                                                'assets/images/default_profile.jpg',
                                                                                // widget.image,
                                                                                height: 250.h,
                                                                                width: 150.w,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10.h,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Padding(
                                                                                padding: const EdgeInsets.only(left: 5, right: 10),
                                                                                child: listVieProfileRecord['image'] != null || listVieProfileRecord['image'] != ''
                                                                                    ? Container(
                                                                                        height: 40,
                                                                                        width: 40,
                                                                                        decoration: BoxDecoration(
                                                                                          shape: BoxShape.circle,
                                                                                          color: Colors.purple.withOpacity(0.1),
                                                                                          image: DecorationImage(
                                                                                            image: NetworkImage(listVieProfileRecord['image']),
                                                                                            // Replace 'assets/your_image.png' with the actual path to your image
                                                                                            fit: BoxFit.cover, // You can adjust the fit based on your requirements
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    : Container(
                                                                                        height: 40,
                                                                                        width: 40,
                                                                                        decoration: BoxDecoration(
                                                                                          shape: BoxShape.circle,
                                                                                          // color: Colors.transparent,
                                                                                          image: DecorationImage(
                                                                                            image: AssetImage('assets/images/default_profile.jpg'),
                                                                                            fit: BoxFit.cover, // You can adjust the fit based on your requirements
                                                                                          ),
                                                                                        ),
                                                                                      )),
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Text(
                                                                                  listVieProfileRecord['name'],
                                                                                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                                                                                ),
                                                                                (listVieProfileRecord['location'] != '' && listVieProfileRecord['location'] != null)
                                                                                    ? Text(
                                                                                  listVieProfileRecord['location'],
                                                                                        style: TextStyle(fontSize: 14.sp),
                                                                                      )
                                                                                    : SizedBox.shrink(),
                                                                                (listVieProfileRecord['age'] != '' && listVieProfileRecord['age'] != null)
                                                                                    ? Text(
                                                                                  listVieProfileRecord['age'],
                                                                                        style: TextStyle(fontSize: 14.sp),
                                                                                      )
                                                                                    : SizedBox.shrink(),
                                                                                (listVieProfileRecord['height'] != '' && listVieProfileRecord['height'] != null)
                                                                                    ? Text(
                                                                                  listVieProfileRecord['height'],
                                                                                        style: TextStyle(fontSize: 14.sp),
                                                                                      )
                                                                                    : Text(''),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),

                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10.h,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  );
                                                },
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            );
          });
    });
  }

  Widget buildFilterDropdown(
      String label, List<String> options, String? selectedValue) {
    return Consumer<AppProvider>(builder: (context, provider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Container(
                  width: 180.w,
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$label:'),
                      SizedBox(
                        width: 10.w,
                      ),
                      Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                            // color: Colors.green
                            // color: Colors.purple.withOpacity(0.1),
                            ),
                        child: DropdownButton<String>(
                          underline: Container(),
                          isExpanded: true,
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              switch (label) {
                                case 'Height':
                                  selectedHeight = value;
                                  break;
                                case 'Weight':
                                  selectedWeight = value;
                                  break;
                                case 'Age':
                                  selectedAge = value;
                                  break;
                              }
                            });
                            provider.setFilter(false);
                            provider.setFilterOption(value.toString());
                            print(
                                'tttt${provider.isFilter},  ${provider.FilterOption}');
                          },
                          items: options.map((option) {
                            print('fffff${option}');
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      );
    });
  }
}
