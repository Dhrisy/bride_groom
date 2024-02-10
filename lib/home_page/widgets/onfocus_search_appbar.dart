// import 'package:bride_groom/components/reusable_text_field.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
//
// import '../../authentication/sign_up_page/provider.dart';
// import '../home_page.dart';
//
// class OnFocusSearchAppBar extends StatefulWidget {
//    OnFocusSearchAppBar({Key? key,
//   required this. document,
//    }) : super(key: key);
//   final List<DocumentSnapshot> document;
//
//
//   @override
//   State<OnFocusSearchAppBar> createState() => _OnFocusSearchAppBarState();
// }
//
// class _OnFocusSearchAppBarState extends State<OnFocusSearchAppBar> {
//   TextEditingController search_controller = TextEditingController();
//
//
//   List<Map<String, dynamic>> profiles = [
//     {
//       'image': 'path/to/image1.png',
//       'name': 'John Doe',
//       'location': 'New York',
//       'height': 180,
//       'weight': 70,
//     },
//     {
//       'image': 'path/to/image2.png',
//       'name': 'Jane Doe',
//       'location': 'California',
//       'height': 160,
//       'weight': 50,
//     },
//     // Add more profiles as needed
//   ];
//   List<Map<String, dynamic>> filteredProfiles = [];
//
//
//   // String? newCustomFunction(
//   //     String? searchitem,
//   //     List? listitems,
//   //     ) {
//   //   // the documents have ''location" , when searchitem conatins in document[''location]'retun doc
//   //   return listitems?.contains(searchitem!) == true ? listitems : null;
//   // }
//
//   List<DocumentSnapshot>? newCustomFunction(
//       String? searchItem,
//       List<DocumentSnapshot> listItems,
//       ) {
//     // Filter documents that contain the searchItem in the 'location' field
//     List<DocumentSnapshot>? matchingDocuments = listItems
//         .where((document) =>
//     document['location'] != null &&
//         document['location'].toString().contains(searchItem!))
//         .toList();
//
//     // Return the matching documents if any, otherwise, return null
//     return matchingDocuments.isNotEmpty ? matchingDocuments : null;
//   }
//   List<String> locations = [];
//
//
//   Future<List<String>> fetchLocations() async {
//     try {
//       QuerySnapshot querySnapshot =
//       await FirebaseFirestore.instance.collection('users').get();
//
//
//       querySnapshot.docs.forEach((doc) {
//         // Check if the 'location' field exists and is not null
//         // if (doc['location'] != null) {
//           String location = doc['location'].toString();
//           if (!locations.contains(location)) {
//             // Avoid duplicates
//             locations.add(location);
//             print('kkkk${locations}');
//           }
//
//       });
//
//       return locations;
//     } catch (error) {
//       print('Error fetching locations: $error');
//       return [];
//     }
//   }
//
//   List<String> searchResults = [];
//
//   void onQueryChanged(String query) {
//     setState(() {
//       searchResults = locations
//           .where((item) => item.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }
//
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     fetchLocations();
//     filteredProfiles = List.from(profiles);
//   }
//
//   void filterProfiles(String searchText) {
//     setState(() {
//       filteredProfiles = profiles
//           .where((profile) =>
//       profile['location'].toLowerCase().contains(searchText.toLowerCase()) ||
//           profile['height'].toString().contains(searchText) ||
//           profile['weight'].toString().contains(searchText))
//           .toList();
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AppProvider>(
//         builder: (context, seachProvider, child) {
//           return Row(
//             children: [
//               SizedBox(
//                 width: 5.w,
//               ),
//               Expanded(
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.purple.withOpacity(0.1),
//                     borderRadius: BorderRadius.all(Radius.circular(10.r))
//
//                   ),
//                   child: TextFormField(
//                    onChanged: (value){
//                      newCustomFunction(
//                        search_controller.text,
//                        widget.document
//                      );
//                    },
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Colors.blue, // Set your desired border color
//                           width: 2.0, // Set the border width
//                         ),
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       filled: true,
//                       fillColor: Colors.transparent,
//                       hintText: 'Enter text',
//                       labelText: 'Label',
//                     ),
//                   ),
//                 )
//               ),
//               TextButton(
//                 onPressed: () {
//                   seachProvider.setSearching(false);
//                   // search_controller.clear();
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
//                 },
//                 child: Container(
//                     height: 40,
//                     width: 40,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.purple.withOpacity(0.1), // Set the desired color
//                     ),
//                     child: Icon(Icons.close)
//                 ),
//               ),
//             ],
//           );
//         });
//   }
// }
