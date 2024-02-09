import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridViewImages extends StatelessWidget {
   GridViewImages({Key? key}) : super(key: key);




  final List<String> images = [
    'assets/images/m1.jpg',
    'assets/images/m2.jpg',
    'assets/images/m3.jpg',
    // Add more image paths as needed
  ];


   //
   // Column(
   // mainAxisAlignment: MainAxisAlignment.center,
   // // crossAxisAlignment: CrossAxisAlignment.center,
   // //     mainAxisSize: MainAxisSize.min,
   // children: [
   // Row(
   // mainAxisAlignment: MainAxisAlignment.center,
   // children: [
   // Container(
   // height: 100.h,
   // width: 100.w,
   // decoration: BoxDecoration(
   // shape: BoxShape.rectangle,
   // borderRadius: BorderRadius.all(Radius.circular(25)),
   // image: DecorationImage(
   // image: AssetImage('assets/images/default-image.png'),
   // )
   // ),
   //
   // ),
   // ],
   // ),
   // Text('No uploaded images',
   // style: TextStyle(
   // color: Colors.grey
   // ),)
   // ],
   // )

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: images.isEmpty
           ? Center(
         child: Text(
           'No uploaded images',
           style: TextStyle(
             color: Colors.grey
           ),
         ),
       )
           : GridView.builder(
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
           crossAxisCount: 2, // You can change this value based on your layout preference
           crossAxisSpacing: 0.0,
           mainAxisSpacing: 0.0,
         ),
         itemCount: images.length,
         itemBuilder: (BuildContext context, int index) {
           return Container(
             padding: EdgeInsets.only(top: 5, left: 5, right: 5),
             child: Image.asset(
               images[index],
               fit: BoxFit.cover,
             ),
           );
         },
       ),
     );
   }
}
