
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../authentication/provider/provider.dart';
import '../../custom_functions/custom_functions.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.user_data,
    this.isLoading,
  }) : super(key: key);

  final Map<String, dynamic>? user_data;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    print(user_data?['image']);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('user_id', isEqualTo: user_data?['user_id'])
            .snapshots(),
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

      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }

      // Access the data
      QuerySnapshot querySnapshot = snapshot.data!;
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      // access data from  documents
      for (QueryDocumentSnapshot document in documents) {
        Map<String, dynamic>? userData = document.data() as Map<String, dynamic>;
        print(userData['image']);
        print(userData['email']);
        // ... Access other fields
      }
      QueryDocumentSnapshot document = documents.first;
      Map<String, dynamic> userData = document.data() as Map<String, dynamic>;

        return Consumer<AppProvider>(builder: (context, provider, child) {
          return Container(
              child: (user_data == null || user_data == '') && isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.blue),
                      strokeWidth: 5.0,
                    ))
                  : Column(
                      children: [
                        SizedBox(height: 10.h),
                        if( userData['image'] == '' )
                        // if (user_data?['image'].isNotEmpty)
                          Container(
                            height: 100.h,
                            width: 100.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/default_profile.jpg'), // Add your image path
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        if( userData['image'] != '' && userData['image'] != null)
                          Container(
                            height: 100.h,
                            width: 100.h,
                            decoration: BoxDecoration(
                              // color: Colors.green,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(userData['image']), // Add your image path
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userData['name'] == null || userData['name'] == ''
                                  ? 'Not available'
                                  : CustomFunctions.toSentenceCase(userData['name']!),
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 35.h,
                          decoration: BoxDecoration(
                              color: Colors.purple.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                userData['email'] ?? 'Not available',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.purple,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ));
        });
      }
    );
  }
}
