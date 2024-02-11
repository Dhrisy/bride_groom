import 'package:bride_groom/custom_functions/custom_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OppositeGenderProfile extends StatefulWidget {
   OppositeGenderProfile({Key? key, required this.userData ,
   }) : super(key: key);
   final DocumentSnapshot userData;

   @override
  State<OppositeGenderProfile> createState() => _OppositeGenderProfileState();
}

class _OppositeGenderProfileState extends State<OppositeGenderProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
             widget.userData['name'],
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500
            ),),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100.h,
                        width: 100.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/default_profile.jpg'),
                            // Add your image path
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: widget.userData['image'] != '' || widget.userData['image'] != null
                  ? ClipOval(
                          child: Image.network(
                            widget.userData['image'],
                            height: 100.0,
                            width: 100.0,
                            fit: BoxFit.cover,
                          ),
                        ): SizedBox.shrink()
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                            children: [
                              SizedBox(height: 10.h,),
                              Row(
                                children: [
                                  Text('Personal details',
                                    style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w600
                                    ),)
                                ],
                              ),
                              SizedBox(height: 5.h,),
                              _personalDetails(context),
                              SizedBox(height: 10.h,),
                              Row(
                                children: [
                                  Text('Family details',
                                    style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w600
                                    ),)
                                ],
                              ),
                              SizedBox(height: 5.h,),
                              _familyDetails(context),
                              SizedBox(height: 10.h,),
                              Row(
                                children: [
                                  Text('Contact details',
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w600
                                  ),)
                                ],
                              ),
                              SizedBox(height: 5.h,),
                              _conatctDetailsCard(context),
                            ],
                          )
                      )
                    ],
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }

  _personalDetails( BuildContext context){
    return Container(
      decoration: BoxDecoration(
          color: Colors.purple.withOpacity(0.1),
          borderRadius: BorderRadius.all(Radius.circular(20.r))
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Date fo birth",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    ':',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.userData['date_of_birth'] == 'Not available' || widget.userData['date_of_birth'] == null
                        ? 'Not available': CustomFunctions.toSentenceCase(widget.userData['date_of_birth']),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h,),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Place of birth",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    ':',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.userData['location'] == 'Not available' || widget.userData['location'] == null
                        ? 'Not available': CustomFunctions.toSentenceCase(widget.userData['location']),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h,),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Education',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    ':',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.userData['education'] == 'Not available' || widget.userData['education'] == null
                        ? 'Not available': CustomFunctions.toSentenceCase(widget.userData['education']),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h,),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Job',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    ':',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.userData['job'] == 'Not available' || widget.userData['job'] == null
                        ? 'Not available': CustomFunctions.toSentenceCase(widget.userData['job']),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


  _familyDetails( BuildContext context){
    return Container(
      decoration: BoxDecoration(
          color: Colors.purple.withOpacity(0.1),
          borderRadius: BorderRadius.all(Radius.circular(20.r))
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [

            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Father's name",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    ':',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.userData['father_name'] == 'Not available' || widget.userData['father_name'] == null
                        ? 'Not available': widget.userData['father_name'],
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h,),

            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Mother's name",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    ':',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.userData['mother_name'] == 'Not available' || widget.userData['mother_name'] == null
                        ? 'Not available': widget.userData['mother_name'],
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 5.h,),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Siblings',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    ':',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.userData['siblings'] == 'Not available' || widget.userData['siblings'] == null
                        ? 'Not available': widget.userData['siblings'],
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    ':',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.userData['description'] == 'Not available' || widget.userData['description'] == null
                        ? 'Not available': widget.userData['description'],
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            )




          ],

        ),
      ),
    );
  }

  _conatctDetailsCard(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.1),
        borderRadius: BorderRadius.all(Radius.circular(20.r))
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [

            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Contact person name',
                          style: TextStyle(
                            fontSize: 18.sp,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    ':',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.userData['name'] == '' || widget.userData['name'] == null
                        ? 'Not available': widget.userData['name'],
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Contact number',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    ':',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.userData['phone'] == '' || widget.userData['phone'] == null
                        ? 'Not available': widget.userData['phone'],
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    ':',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.userData['email'] == '' || widget.userData['email'] == null
                        ? 'Not available': widget.userData['email'],
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Place',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    ':',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),

                Expanded(
                  child: Text(
                    (widget.userData['location'] == 'Not available')
                    ? 'Not available'
                   :'${widget.userData['location']}',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(

                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'State',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    ':',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),

                Expanded(
                  child: Text(
                    (widget.userData['state'] == 'Not available')
                        ? 'Not available'
                        :'${widget.userData['state']}',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Country',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    ':',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),

                Expanded(
                  child: Text(
                    (widget.userData['country'] == 'Not available')
                        ? 'Not available'
                        :'${widget.userData['country']}',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),






          ],

        ),
      ),
    );
  }
}
