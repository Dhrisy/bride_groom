// import 'dart:io';
//
// import 'package:bride_groom/profile/opposite_gender_profile/oppopsite_gender_profile.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class ProfileCard extends StatefulWidget {
//   const ProfileCard({Key? key,
//     required this.image,
//     required this.name,
//     required this.document,
//     this.index,
//     required this.location,
//
//
//   }) : super(key: key);
//
//   final String image;
//   final String name;
//   final List<DocumentSnapshot> document;
//   final int? index;
//   final String location;
//
//
//
//   @override
//   State<ProfileCard> createState() => _ProfileCardState();
// }
//
// class _ProfileCardState extends State<ProfileCard> {
//
//   int? index_image ;
//
// @override
// void initState() {
//     super.initState();
//     setState(() {
//       // index_image = widget.index;
//     });
//     print('uuuuuuuuuuu${widget.image}');
//   }
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
//       child: InkWell(
//         onTap: (){
//           Navigator.push(context, MaterialPageRoute(builder: (context) => OppositeGenderProfile(
//
//           )));
//         },
//         child: Container(
//
//
//           height: 350.h,
//           // width: 0.w,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.all(Radius.circular(20.r)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 spreadRadius: 1.2,
//                 blurRadius: 5,
//                 offset: Offset(1, 1),
//               ),
//
//             ],
//           ),
//           child: Column(
//             children: [
//               Container(
//                 width: double.infinity,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(13.r),
//                       topRight:
//                           Radius.circular(13.r)), // Set the desired border radius
//                   child: widget.image == ''?   SizedBox(
//                     height: 20.r,
//                     width: 20.r,
//                     child: CircularProgressIndicator(color: Colors.white),
//                   ):
//                   // widget.image != null && widget.image != ''
//                   // ? Image.network(
//                   //   widget.image,
//                   //   // widget.image,
//                   //   height: 250.h,
//                   //   width: 150.w,
//                   //   fit: BoxFit.cover,
//                   // )
//                   //     :
//                   Image.asset(
//                     'assets/images/default_profile.jpg',
//                     // widget.image,
//                     height: 250.h,
//                     width: 150.w,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10.h,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//
//                       Padding(
//                         padding: const EdgeInsets.only(left: 5, right: 10),
//                         child:
//                         widget.image != null || widget.image != ''
//                         ? Container(
//                           height: 40,
//                           width: 40,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.purple.withOpacity(0.1),
//                             image: DecorationImage(
//                               image: NetworkImage(widget.image), // Replace 'assets/your_image.png' with the actual path to your image
//                               fit: BoxFit.cover, // You can adjust the fit based on your requirements
//                             ),
//                           ),
//                         ) :
//                         Container(
//                           height: 40,
//                           width: 40,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.purple.withOpacity(0.1),
//                             image: DecorationImage(
//                               image: AssetImage(
//                                   'assets/images/default_profile.jpg'),// Replace 'assets/your_image.png' with the actual path to your image
//                               fit: BoxFit.cover, // You can adjust the fit based on your requirements
//                             ),
//                           ),
//                         )
//                       ),
//
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           Text(
//                             widget.name,
//                             style: TextStyle(
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.w500
//                             ),
//                           ),
//                           Text(
//                             widget.document[index_image ?? 0]['location'].toString(),
//                             style: TextStyle(
//                                 fontSize: 14.sp
//                             ),
//                           ),
//                           Text(
//                             'height : 100',
//                             style: TextStyle(
//                                 fontSize: 14.sp
//                             ),
//                           ),
//                           Text(
//                             'weight: 40',
//                             style: TextStyle(
//                                 fontSize: 14.sp
//                             ),
//                           )
//                         ],
//                       ),
//
//                     ],
//                   ),
//                   Icon(Icons.more_vert_outlined)
//                 ],
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
